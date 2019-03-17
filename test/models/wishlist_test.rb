require 'test_helper'

class WishlistTest < ActiveSupport::TestCase
  
  def setup
    @wishlist = Wishlist.new(user_id:     users(:aman).id,
                             property_id: properties(:salt_lake).id)
  end

  test "should be valid" do
    assert @wishlist.valid?
  end

  test "should require a user_id" do
    @wishlist.user_id = nil
    assert_not @wishlist.valid?
  end

  test "should require a property_id" do
    @wishlist.property_id = nil
    assert_not @wishlist.valid?
  end

  test "order should be most recent first" do
    assert_equal wishlists(:most_recent), Wishlist.first
  end
end
