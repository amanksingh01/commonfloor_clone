require 'test_helper'

class WishlistsControllerTest < ActionDispatch::IntegrationTest
  
  test "create should require logged-in user" do
    assert_no_difference 'Wishlist.count' do
      post wishlists_path, params: { property_id: properties(:salt_lake).id }
    end
    assert_redirected_to login_url
  end

  test "destroy should require logged-in user" do
    assert_no_difference 'Wishlist.count' do
      delete wishlist_path(wishlists(:one))
    end
    assert_redirected_to login_url
  end

  test "should redirect create for unapproved property" do
    log_in_as(users(:oliver))
    assert_no_difference 'Wishlist.count' do
      post wishlists_path, params: { property_id: properties(:unapproved).id }
    end
    assert_redirected_to root_url
  end

  test "should redirect create for sold property" do
    log_in_as(users(:barry))
    assert_no_difference 'Wishlist.count' do
      post wishlists_path, params: { property_id: properties(:sold).id }
    end
    assert_redirected_to root_url
  end
end