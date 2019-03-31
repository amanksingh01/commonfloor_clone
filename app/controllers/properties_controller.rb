class PropertiesController < ApplicationController
  before_action :logged_in_user,         except: [:index, :search]
  before_action :get_property,           only:   [:edit, :update, :destroy,
                                                  :interested_users,
                                                  :mark_as_sold]
  before_action :get_property_for_admin, only:   [:edit, :update, :destroy]
  before_action :correct_user,           only:   [:edit, :update, :destroy,
                                                  :interested_users,
                                                  :mark_as_sold]
  before_action :sold_property,          only:   [:edit, :update, :destroy,
                                                  :interested_users,
                                                  :mark_as_sold]

  def index
    @properties = Property.include_sold(params[:include_sold])
                          .paginate(page: params[:page], per_page: 12)
    filtering_params.each do |key, value|
      @properties = @properties.send(key, value) if value.present?
    end
    @title = "Browse properties"
  end

  def show
    @property = Property.find(params[:id])
    @comments = @property.comments.paginate(page: params[:page], per_page: 12)
    @comment  = current_user.comments.build
  end

  def new
    @property = current_user.properties.build
  end

  def create
    @property = current_user.properties.build(property_params)
    if @property.save
      current_user.update_attribute(:seller, true) unless current_user.seller?
      flash[:success] = "Property posted!"
      redirect_to @property
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @property.update_attributes(property_params)
      flash[:success] = "Property details updated"
      redirect_to @property
    else
      render 'edit'
    end
  end

  def destroy
    @property.destroy
    flash[:success] = "Property deleted"
    redirect_to @property.user
  end

  def interested_users
    @users = @property.interested_users
                      .order('wishlists.created_at ASC')
                      .paginate(page: params[:page], per_page: 24)
    @title = "Interested users"
    render 'shared/users'
  end

  def search
    @properties = Property.include_sold(params[:include_sold])
                          .paginate(page: params[:page], per_page: 12)
    @properties = @properties.search(params[:q]) if params[:q].present?
    filtering_params.each do |key, value|
      @properties = @properties.send(key, value) if value.present?
    end
    @title = "Search results"
  end

  def mark_as_sold
    @property.mark_as_sold
    flash[:success] = "Property marked as sold!"
    redirect_to @property
  end

  private

    def property_params
      params.require(:property).permit(:owner_name, :property_type,
                                       :property_status, :bed_rooms, :area,
                                       :price, :street_address, :locality,
                                       :city, :state, :pincode, :country,
                                       :picture)
    end

    # Before filters

    # Retrieves the property from the database.
    def get_property
      @property = current_user.properties.find_by(id: params[:id])
    end

    # Retrieves the property for admin users.
    def get_property_for_admin
      if @property.nil? && current_user.admin?
        @property = Property.find(params[:id])
      end
    end

    # Checks whether the user has permission to modify property details.
    def correct_user
      redirect_to root_url if @property.nil?
    end

    # Prevents user from modifying property details for sold property.
    def sold_property
      redirect_to root_url if @property.sold?
    end
end