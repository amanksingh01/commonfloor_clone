require 'test_helper'

class FavoritesTest < ActionDispatch::IntegrationTest

  def setup
    @user     = users(:aman)
    @property = properties(:new_town)
    log_in_as(@user)
  end

  test "favorites page" do
    get favorites_user_path(@user)
    assert_template 'users/favorites'
    assert_not @user.favorites.empty?
    assert_match @user.favorites.count.to_s, response.body
    @user.favorites.each do |property|
      assert_select "a[href=?]", property_path(property), text: "View details"
    end
  end

  test "interested_users page" do
    property = properties(:dum_dum)
    get interested_users_property_path(property)
    assert_template 'properties/interested_users'
    assert_not property.interested_users.empty?
    assert_match property.interested_users.count.to_s, response.body
    property.interested_users.each do |user|
      assert_select "a[href=?]", user_path(user), text: "View profile"
    end
  end

  test "should add to favorites a property" do
    assert_difference '@user.favorites.count', 1 do
      post wishlists_path, params: { property_id: @property.id }
    end
    assert_not flash.empty?
    assert_redirected_to @property
  end

  test "should remove from favorites a property" do
    @user.add_to_favorites(@property)
    wishlist = @user.wishlists.find_by(property_id: @property.id)
    assert_difference '@user.favorites.count', -1 do
      delete wishlist_path(wishlist)
    end
    assert_not flash.empty?
    assert_redirected_to @property
  end
end