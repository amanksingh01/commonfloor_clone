class PropertiesController < ApplicationController
  before_action :logged_in_user,         except: [:index, :search]
  before_action :get_property,           only:   [:edit, :update, :destroy,
                                                  :interested_users,
                                                  :mark_as_sold]
  before_action :get_property_for_admin, only:   [:edit, :update, :destroy,
                                                  :approve]
  before_action :correct_user,           only:   [:edit, :update, :destroy,
                                                  :interested_users,
                                                  :mark_as_sold]
  before_action :admin_user,             only:   [:unapproved, :sold, :approve]
  before_action :approved_property,      only:   [:interested_users,
                                                  :mark_as_sold]
  before_action :sold_property,          only:   [:edit, :update, :destroy,
                                                  :interested_users,
                                                  :mark_as_sold]

  def index
    @properties = Property.where(approved: true)
                          .include_sold(params[:include_sold])
                          .paginate(page: params[:page], per_page: 12)
    filtering_params.each do |key, value|
      @properties = @properties.send(key, value) if value.present?
    end
    @title = "Browse properties"
  end

  def show
    @property = Property.find(params[:id])
    unless @property.approved? || current_user?(@property.user) ||
           current_user.admin?
      redirect_to root_url and return
    end
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
      flash[:success] = "Property posted! It will be live once we verify and " +
                        "approve the details."
      redirect_to @property
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @property.update_attributes(property_params)
      @property.disapprove if @property.approved?
      flash[:success] = "Property details updated! It will be live once we " +
                        "verify and approve the details."
      redirect_to @property
    else
      render 'edit'
    end
  end

  def destroy
    @property.destroy
    flash[:success] = "Property deleted!"
    redirect_to @property.user
  end

  def search
    @properties = Property.where(approved: true)
                          .include_sold(params[:include_sold])
                          .paginate(page: params[:page], per_page: 12)
    @properties = @properties.search(params[:q]) if params[:q].present?
    filtering_params.each do |key, value|
      @properties = @properties.send(key, value) if value.present?
    end
    @title = "Search results"
  end

  def unapproved
    @properties = Property.where(approved: false)
                          .paginate(page: params[:page], per_page: 12)
    filtering_params.each do |key, value|
      @properties = @properties.send(key, value) if value.present?
    end
    @title = "Unapproved properties"
  end

  def sold
    @properties = Property.where(sold: true)
                          .order(:sold_at)
                          .paginate(page: params[:page], per_page: 12)
    @title = "Sold properties"
    @properties_grid_col = "col-md-6 col-lg-3"
  end

  def approve
    @property.approve(current_user)
    flash[:success] = "Property approved!"
    redirect_to @property
  end

  def interested_users
    @users = @property.interested_users
                      .order('wishlists.created_at ASC')
                      .paginate(page: params[:page], per_page: 24)
    @title = "Interested users"
    render 'shared/users'
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
                                       :image)
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
end