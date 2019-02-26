class PropertiesController < ApplicationController
  before_action :logged_in_user, except: :index

  def index
    @properties = Property.paginate(page: params[:page], per_page: 12)
  end

  def show
    @property = Property.find(params[:id])
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
