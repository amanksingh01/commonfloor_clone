class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    def filtering_params
      params.permit(:property_type, :property_status, :bed_rooms, :area,
                    :price, :order_by)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    # Redirects for an unapproved property.
    def approved_property
      redirect_to root_url unless @property.approved?
    end

    # Prevents user from modifying property details for sold property.
    def sold_property
      redirect_to root_url if @property.sold?
    end
end
