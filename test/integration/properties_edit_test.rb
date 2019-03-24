require 'test_helper'

class PropertiesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin    = users(:aman)
    @user     = users(:barry)
    @property = properties(:salt_lake)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_property_path(@property)
    assert_template 'properties/edit'
    patch property_path(@property), params: { property: { 
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
    assert_template 'properties/edit'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    assert_select 'div.alert', text: 'The form contains 18 errors.'
  end

  test "successful edit with friendly forwarding" do
    get edit_property_path(@property)
    assert_not_nil session[:forwarding_url]
    log_in_as(@user)
    assert_redirected_to edit_property_path(@property)
    price = 4000000
    patch property_path(@property), 
          params: { property: { owner_name:      @property.owner_name,
                                property_type:   @property.property_type,
                                property_status: @property.property_status,
                                bed_rooms:       @property.bed_rooms,
                                area:            @property.area,
                                price:           price,
                                street_address:  @property.street_address,
                                locality:        @property.locality,
                                city:            @property.city,
                                state:           @property.state,
                                pincode:         @property.pincode,
                                country:         @property.country } }
    assert_not flash.empty?
    assert_redirected_to @property
    assert_nil session[:forwarding_url]
    @property.reload
    assert_equal price, @property.price
  end

  test "successful edit by admin with friendly forwarding" do
    get edit_property_path(@property)
    assert_not_nil session[:forwarding_url]
    log_in_as(@admin)
    assert_redirected_to edit_property_path(@property)
    price = 4000000
    patch property_path(@property), 
          params: { property: { owner_name:      @property.owner_name,
                                property_type:   @property.property_type,
                                property_status: @property.property_status,
                                bed_rooms:       @property.bed_rooms,
                                area:            @property.area,
                                price:           price,
                                street_address:  @property.street_address,
                                locality:        @property.locality,
                                city:            @property.city,
                                state:           @property.state,
                                pincode:         @property.pincode,
                                country:         @property.country } }
    assert_not flash.empty?
    assert_redirected_to @property
    assert_nil session[:forwarding_url]
    @property.reload
    assert_equal price, @property.price
  end
end
