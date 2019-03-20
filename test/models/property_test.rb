require 'test_helper'

class PropertyTest < ActiveSupport::TestCase
  def setup
    @user = users(:aman)
    @property = @user.properties.build(owner_name:      "ajay sharma",
                                       property_type:   "apartment",
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
  end

  test "should be valid" do
    assert @property.valid?
  end

  test "user id should be present" do
    @property.user_id = nil
    assert_not @property.valid?
  end

  test "owner_name should be present" do
    @property.owner_name = "     "
    assert_not @property.valid?
  end

  test "property_type should be present" do
    @property.property_type = "     "
    assert_not @property.valid?
  end

  test "property_status should be present" do
    @property.property_status = "     "
    assert_not @property.valid?
  end

  test "bed_rooms should be present" do
    @property.bed_rooms = "     "
    assert_not @property.valid?
  end

  test "area should be present" do
    @property.area = "     "
    assert_not @property.valid?
  end

  test "price should be present" do
    @property.price = "     "
    assert_not @property.valid?
  end

  test "street_address should be present" do
    @property.street_address = "     "
    assert_not @property.valid?
  end

  test "locality should be present" do
    @property.locality = "     "
    assert_not @property.valid?
  end

  test "city should be present" do
    @property.city = "     "
    assert_not @property.valid?
  end

  test "state should be present" do
    @property.state = "     "
    assert_not @property.valid?
  end

  test "pincode should be present" do
    @property.pincode = "     "
    assert_not @property.valid?
  end

  test "country should be present" do
    @property.country = "     "
    assert_not @property.valid?
  end

  test "owner_name should not be too long" do
    @property.owner_name = "a" * 51
    assert_not @property.valid?
  end

  test "property_type should be valid" do
    @property.property_type = "aaaa"
    assert_not @property.valid?
  end

  test "property_status should be valid" do
    @property.property_status = "aaaa"
    assert_not @property.valid?
  end

  test "bed_rooms should be valid" do
    @property.bed_rooms = "aaaa"
    assert_not @property.valid?
  end

  test "area should be numeric" do
    @property.area = "aaaa"
    assert_not @property.valid?
  end

  test "price should be numeric" do
    @property.price = "aaaa"
    assert_not @property.valid?
  end

  test "pincode should be numeric and integer" do
    @property.pincode = "aaaa"
    assert_not @property.valid?
    @property.pincode = 123.45
    assert_not @property.valid?
  end

  test "area should be greater than 0" do
    @property.area = 0.0
    assert_not @property.valid?
  end

  test "price should be greater than 0" do
    @property.price = 0.0
    assert_not @property.valid?
  end

  test "pincode should be of length 6" do
    @property.pincode = "12345"
    assert_not @property.valid?
  end

  test "pincode should be valid" do
    @property.pincode = "012345"
    assert_not @property.valid?
  end

  test "order should be most recent first" do
    assert_equal properties(:most_recent), Property.first
  end

  test "owner name should be saved as lower-case" do
    mixed_case_owner_name = "A pErSon"
    @property.owner_name = mixed_case_owner_name
    @property.save
    assert_equal mixed_case_owner_name.downcase, @property.reload.owner_name
  end

  test "street address should be saved as lower-case" do
    mixed_case_street_address = "sOMe sTrEEt"
    @property.street_address = mixed_case_street_address
    @property.save
    assert_equal mixed_case_street_address.downcase, 
                 @property.reload.street_address
  end

  test "locality should be saved as lower-case" do
    mixed_case_locality = "sOMe loCaLiTy"
    @property.locality = mixed_case_locality
    @property.save
    assert_equal mixed_case_locality.downcase, @property.reload.locality
  end

  test "city should be saved as lower-case" do
    mixed_case_city = "sOMe cITy"
    @property.city = mixed_case_city
    @property.save
    assert_equal mixed_case_city.downcase, @property.reload.city
  end

  test "state should be saved as lower-case" do
    mixed_case_state = "sOMe stAtE"
    @property.state = mixed_case_state
    @property.save
    assert_equal mixed_case_state.downcase, @property.reload.state
  end

  test "country should be saved as lower-case" do
    mixed_case_country = "sOMe COunTRy"
    @property.country = mixed_case_country
    @property.save
    assert_equal mixed_case_country.downcase, @property.reload.country
  end

  test "associated wishlists should be destroyed" do
    @property.save
    @user.add_to_favorites(@property)
    assert_difference 'Wishlist.count', -1 do
      @property.destroy
    end
  end
end
