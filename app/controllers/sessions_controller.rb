class SessionsController < ApplicationController
  before_action :already_logged_in, except: :destroy
  
  def new
  end

  def create
    auth = request.env['omniauth.auth']
    if auth.nil?
      @user = User.find_by(email: params[:session][:email].downcase)
      if @user && @user.authenticate(params[:session][:password])
        if @user.activated?
          log_in @user
          params[:session][:remember_me] == '1' ? remember(@user) :
                                                  forget(@user)
          redirect_back_or root_url
        else
          message = "Account not activated. "
          message += "Check your email for the activation link."
          flash[:warning] = message
          redirect_to root_url
        end
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    else
      if auth.info.email.present?
        @identity = Identity.find_or_create_with_omniauth(auth)
        @user     = @identity.user
        log_in @user
        redirect_back_or root_url
      else
        flash[:danger] = "Error, your provider didn't provide your email! " +
                         "Create a new account using your email by " +
                         "navigating to the signup page."
        redirect_to root_url
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
