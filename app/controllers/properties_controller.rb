class PropertiesController < ApplicationController

  def index
    @properties = Property.paginate(page: params[:page], per_page: 12)
  end

  def show
    @property = Property.find(params[:id])
  end
end
