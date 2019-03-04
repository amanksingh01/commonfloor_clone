require 'test_helper'

class PropertiesCreateTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:aman)
    log_in_as(@user)
  end
  
  test "invalid properties information" do
    get new_property_path
    assert_template 'properties/new'
    assert_no_difference 'Property.count' do
      post properties_path, params: { property: {
                                        owner_name:      "",
                                        property_type:   "",
                                        property_status: "",
                                        bed_rooms:       "",
                                        area:            "",
                                        price:           "",
                                        street_address:  "",
                                        locality:        "",
                                        city:            "",
                                        state:           "",
                                        pincode:         "",
                                        country:         "" } }
    end
    assert_template 'properties/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    assert_select "div.alert", text: "The form contains 18 errors."
  end

  test "valid properties information" do
    get new_property_path
    assert_template 'properties/new'
    assert_difference 'Property.count', 1 do
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
    property = assigns(:property)
    assert_equal @user, property.user
    assert_redirected_to property_path(property)
    follow_redirect!
    assert_template 'properties/show'
  end
end
