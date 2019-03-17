require 'test_helper'

class PropertiesShowTest < ActionDispatch::IntegrationTest
  
  def setup
    @property  = properties(:salt_lake)
    @seller    = @property.user
    @admin     = users(:aman)
    @non_admin = users(:oliver)
  end

  test "property display with correct links and friendly forwarding for it's seller" do
    get property_path(@property)
    assert_not_nil session[:forwarding_url]
    log_in_as(@seller)
    assert_redirected_to property_path(@property)
    follow_redirect!
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
    assert_select 'a[href=?]', user_path(@seller), text: @seller.name
    assert_select 'a[href=?]', interested_users_property_path(@property),
                  text: "Interested users (#{@property.interested_users.count})"
    assert_select 'a[href=?]', edit_property_path(@property),
                               text: 'Modify property details'
    assert_select 'a[href=?]', property_path(@property), text: 'Delete property'
  end

  test "property display with correct links for admins" do
    log_in_as(@admin)
    get property_path(@property)
    assert_select 'a[href=?]', user_path(@seller), text: @seller.name
    assert_select 'a[href=?]', interested_users_property_path(@property),
                               count: 0
    assert_template 'properties/_wishlist_form'
    assert_select 'a[href=?]', edit_property_path(@property),
                               text: 'Modify property details'
    assert_select 'a[href=?]', property_path(@property), text: 'Delete property'
  end

  test "property display with correct links for other non-admin users" do
    log_in_as(@non_admin)
    get property_path(@property)
    assert_select 'a[href=?]', user_path(@seller), text: @seller.name
    assert_select 'a[href=?]', interested_users_property_path(@property),
                               count: 0
    assert_template 'properties/_wishlist_form'
    assert_select 'a[href=?]', edit_property_path(@property),
                               text: 'Modify property details',
                               count: 0
    assert_select 'a[href=?]', property_path(@property),
                               text: 'Delete property',
                               count: 0
  end
end
