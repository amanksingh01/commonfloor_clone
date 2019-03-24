class PropertiesController < ApplicationController
  before_action :logged_in_user, except: :index
  before_action :get_property,   only:   [:edit, :update, :destroy]
  before_action :correct_user,   only:   [:edit, :update, :destroy]

  def index
    @properties = Property.paginate(page: params[:page], per_page: 12)
    filtering_params.each do |key, value|
      @properties = @properties.send(key, value) if value.present?
    end
    @title = "Browse properties"
    @properties_grid_col = "col-md-6 col-lg-4"
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
    @property = Property.find(params[:id])
    redirect_to root_url and return unless current_user?(@property.user)
    @users = @property.interested_users.paginate(page: params[:page],
                                                 per_page: 24)
  end

  private

    def property_params
      params.require(:property).permit(:owner_name, :property_type,
                                       :property_status, :bed_rooms, :area,
                                       :price, :street_address, :locality,
                                       :city, :state, :pincode, :country,
                                       :picture)
    end

    def get_property
      @property = current_user.properties.find_by(id: params[:id])
      if @property.nil? && current_user.admin?
        @property = Property.find(params[:id])
      end
    end

    def correct_user
      redirect_to root_url if @property.nil?
    end
end
