require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     mobile_number: "9876543210", password: "foobar",
                     password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.name = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "mobile number should be of length 10" do
    @user.mobile_number = "1" * 5
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                         foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "mobile number should be a number" do
    @user.mobile_number = "a" * 10
    assert_not @user.valid?
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "associated identities should be destroyed" do
    @user.save
    @user.identities.create!(uid: 'uid', provider: 'provider')
    assert_difference 'Identity.count', -1 do
      @user.destroy
    end
  end

  test "associated properties should be destroyed" do
    @user.save
    @user.properties.create!(property_type:   "apartment",
                             owner_name:      "ajay sharma",
                             property_status: "sell",
                             bed_rooms:       "3bhk",
                             area:            "1500.50",
                             price:           "5000000",
                             street_address:  "121, dum dum road",
                             locality:        "dum dum",
                             city:            "kolkata",
                             state:           "west bengal",
                             pincode:         "700074",
                             country:         "india")
    assert_difference 'Property.count', -1 do
      @user.destroy
    end
  end

  test "associated approved properties should be nullified" do
    admin = users(:aman)
    property = properties(:unapproved)

    assert_not     property.approved?
    assert_nil     property.approved_at
    assert_nil     property.approved_by
    
    property.approve(admin)
    assert         property.approved?
    assert_not_nil property.approved_at
    assert_equal   admin, property.approved_by

    admin.destroy
    assert         property.reload.approved?
    assert_not_nil property.approved_at
    assert_nil     property.approved_by
  end

  test "associated wishlists should be destroyed" do
    @user.save
    @user.add_to_favorites(properties(:new_town))
    assert_difference 'Wishlist.count', -1 do
      @user.destroy
    end
  end

  test "should add to wishlist and remove from wishlist a property" do
    user = users(:barry)
    property = properties(:lake_town)
    assert_not user.favorite?(property)
    user.add_to_favorites(property)
    assert user.favorite?(property)
    assert property.interested_user?(user)
    user.remove_from_favorites(property)
    assert_not user.favorite?(property)
  end

  test "associated comments should be destroyed" do
    @user.save
    @user.comments.create!(property: properties(:new_town),
                           comment: "Lorem ipsum")
    assert_difference 'Comment.count', -1 do
      @user.destroy
    end
  end

  test "associated approved comments should be nullified" do
    admin = users(:aman)
    comment = comments(:unapproved)

    assert_not     comment.approved?
    assert_nil     comment.approved_at
    assert_nil     comment.approved_by
    
    comment.approve(admin)
    assert         comment.approved?
    assert_not_nil comment.approved_at
    assert_equal   admin, comment.approved_by

    admin.destroy
    assert         comment.reload.approved?
    assert_not_nil comment.approved_at
    assert_nil     comment.approved_by
  end

  test "associated bought properties should be nullified" do
    buyer = users(:oliver)
    property = properties(:new_town)

    assert_not     property.sold?
    assert_nil     property.sold_at
    assert_nil     property.buyer
    
    property.sell(buyer)
    assert         property.reload.sold?
    assert_not_nil property.sold_at
    assert_equal   buyer, property.buyer

    buyer.destroy
    assert         property.reload.sold?
    assert_not_nil property.sold_at
    assert_nil     property.buyer
  end
end