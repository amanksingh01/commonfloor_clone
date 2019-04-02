require 'test_helper'

class FavoritesTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:aman)
    log_in_as(@user)
    ActionMailer::Base.deliveries.clear
  end

  test "favorites page" do
    get favorites_user_path(@user)
    assert_template 'users/favorites'
    assert_template 'shared/_properties'
    assert_template 'shared/_filters'
    assert_select 'aside.filters form[action=?]', favorites_user_path(@user)
    favorites = assigns(:properties)
    assert_not favorites.empty?
    favorites.each do |property|
      assert property.approved?
      assert_not property.sold?
      assert_select "a[href=?]", property_path(property), text: "View details"
    end
    # Apply filters
    get favorites_user_path(@user, property_type: "apartment",
                                   include_sold:  "yes")
    favorites = assigns(:properties)
    assert_not favorites.empty?
    favorites.each do |property|
      assert_equal "apartment", property.property_type
    end
    assert_select 'h2.sold-tag', text: 'Sold'
  end

  test "interested_users page" do
    property = properties(:dum_dum)
    get interested_users_property_path(property)
    assert_template 'shared/users'
    assert_not property.interested_users.empty?
    property.interested_users.each do |user|
      assert_select "a[href=?]", user_path(user), text: "View profile"
    end
  end

  test "interested_users order should be oldest first" do
    get interested_users_property_path(properties(:dum_dum))
    assert_equal wishlists(:oldest).user, assigns(:users).first
  end

  test "should add to favorites a property" do
    property = properties(:new_town)
    assert_difference '@user.favorites.count', 1 do
      post wishlists_path, params: { property_id: property.id }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to property
  end

  test "should remove from favorites a property" do
    property = properties(:new_town)
    @user.add_to_favorites(property)
    wishlist = @user.wishlists.find_by(property: property)
    assert_difference '@user.favorites.count', -1 do
      delete wishlist_path(wishlist)
    end
    assert_not flash.empty?
    assert_redirected_to property
  end
end