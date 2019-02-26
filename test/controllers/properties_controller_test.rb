require 'test_helper'

class PropertiesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user     = users(:aman)
    @property = properties(:dum_dum)
  end

  test "should redirect show when not logged in" do
    get property_path(@property)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect new when not logged in" do
    get new_property_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should get new when logged in" do
    log_in_as(@user)
    get new_property_path
    assert_response :success
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Property.count' do
      post properties_path, params: { property: {
                                        owner_name:      "ajay sharma",
                                        property_type:   "apartment",
                                        property_status: "sell",
                                        bed_rooms:       "3bhk",
                                        area:            "1500",
                                        price:           "5000000",
                                        street_address:  "121, dum dum road",
                                        locality:        "dum dum",
                                        city:            "kolkata",
                                        state:           "west bengal",
                                        pincode:         "700074",
                                        country:         "india" } }
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get edit_property_path(@property)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    assert_no_difference 'Property.count' do
      patch property_path(@property), params: {
                                        property: {
                                          owner_name:      "ajay sharma",
                                          property_type:   "apartment",
                                          property_status: "sell",
                                          bed_rooms:       "3bhk",
                                          area:            "1500",
                                          price:           "5000000",
                                          street_address:  "121, dum dum road",
                                          locality:        "dum dum",
                                          city:            "kolkata",
                                          state:           "west bengal",
                                          pincode:         "700074",
                                          country:         "india" } }
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Property.count' do
      delete property_path(@property)
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
