require 'test_helper'

class WishlistsControllerTest < ActionDispatch::IntegrationTest
  
  test "create should require logged-in user" do
    assert_no_difference 'Wishlist.count' do
      post wishlists_path
    end
    assert_redirected_to login_url
  end

  test "destroy should require logged-in user" do
    assert_no_difference 'Wishlist.count' do
      delete wishlist_path(wishlists(:one))
    end
    assert_redirected_to login_url
  end
end