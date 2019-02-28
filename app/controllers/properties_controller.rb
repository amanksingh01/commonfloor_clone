class PropertiesController < ApplicationController
  before_action :logged_in_user, except: :index
  before_action :correct_user,   only:   :destroy

  def index
    @properties = Property.paginate(page: params[:page], per_page: 12)
  end

  def show
    @property = Property.find(params[:id])
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
  end

  def destroy
    @property.destroy
    flash[:success] = "Property deleted"
    redirect_to current_user
  end

  private

    def property_params
      params.require(:property).permit(:owner_name, :property_type,
                                       :property_status, :bed_rooms, :area,
                                       :price, :street_address, :locality,
                                       :city, :state, :pincode, :country)
    end

    def correct_user
      @property = current_user.properties.find_by(id: params[:id])
      redirect_to root_url if @property.nil?
    end
end
