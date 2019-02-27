require 'test_helper'

class PropertiesShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @property = properties(:dum_dum)
  end

  test "property display" do
    user = @property.user
    log_in_as(user)
    assert is_logged_in?
    get property_path(@property)
    assert_template 'properties/show'
    # Property details
    assert_match @property.owner_name.titleize,        response.body
    assert_match @property.property_type.capitalize,   response.body
    assert_match @property.property_status.capitalize, response.body
    assert_match @property.bed_rooms.upcase,           response.body
    assert_match @property.area,                       response.body
    assert_match @property.price,                      response.body
    assert_match @property.street_address.titleize,    response.body
    assert_match @property.locality.titleize,          response.body
    assert_match @property.city.titleize,              response.body
    assert_match @property.state.titleize,             response.body
    assert_match @property.pincode,                    response.body
    assert_match @property.country.titleize,           response.body
    # Users contact deails
    assert_select 'a[href=?]', user_path(user), text: user.name
    assert_match  user.mobile_number, response.body
    # Links to modify/delete property
    assert_select 'a[href=?]', edit_property_path(@property),
                               text: 'Modify property details'
    assert_select 'a[href=?]', property_path(@property), text: 'Delete property'
  end 
end
