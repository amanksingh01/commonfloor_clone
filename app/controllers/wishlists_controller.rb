class WishlistsController < ApplicationController
  before_action :logged_in_user

  def create
    property = Property.find(params[:property_id])
    current_user.add_to_favorites(property)
    property.send_interested_user_email(current_user)
    message = "Added to wishlist! We have also notified the seller regarding " +
              "your interest in the property."
    flash[:success] = message
    redirect_to property
  end

  def destroy
    property = Wishlist.find(params[:id]).property
    current_user.remove_from_favorites(property)
    flash[:success] = "Removed from wishlist!"
    redirect_to property
  end
end