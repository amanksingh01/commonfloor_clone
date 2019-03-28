class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :get_user,       except: [:index, :new, :create]
  before_action :correct_user,   only:   [:edit, :update, :favorites]
  before_action :admin_user,     only:   [:index, :destroy]
  
  def index
    @users = User.where(activated: true).paginate(page: params[:page],
                                                  per_page: 24)
    @title = "Users"
    render 'shared/users'
  end
  
  def show
    unless @user.activated? && (current_user?(@user) || current_user.admin? ||
                                @user.properties.any?)
      redirect_to root_url and return
    end
    @properties = @user.properties.include_sold(params[:include_sold])
                                  .paginate(page: params[:page], per_page: 12)
    filtering_params.each do |key, value|
      @properties = @properties.send(key, value) if value.present?
    end
    @title = "Your listed properties"
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def favorites
    @properties = @user.favorites.include_sold(params[:include_sold])
                                 .paginate(page: params[:page], per_page: 12)
    filtering_params.each do |key, value|
      @properties = @properties.send(key, value) if value.present?
    end
    @title = "Wishlist"
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :mobile_number, :password,
                                   :password_confirmation)
    end

    # Before filters

    # Retrieves the user from the database.
    def get_user
      @user = User.find(params[:id])
    end

    # Confirms the correct user.
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
