require 'test_helper'

class PropertiesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin               = users(:aman)
    @user                = users(:barry)
    @other_user          = users(:oliver)
    @property            = properties(:salt_lake)
    @sold_property       = properties(:sold)
    @unapproved_property = properties(:unapproved)
  end

  test "should redirect show when not logged in" do
    get property_path(@property)
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect show for unapproved property" do
    log_in_as(@other_user)
    get property_path(@unapproved_property)
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should get show for unapproved property if current user is it's seller" do
    log_in_as(@user)
    get property_path(@unapproved_property)
    assert_response :success
  end

  test "should get show for unapproved property if current user is admin" do
    log_in_as(@admin)
    get property_path(@unapproved_property)
    assert_response :success
  end

  test "should redirect new when not logged in" do
    get new_property_path
    assert_redirected_to login_url
    assert_not flash.empty?
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
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect edit when not logged in" do
    get edit_property_path(@property)
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect update when not logged in" do
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
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Property.count' do
      delete property_path(@property)
    end
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect unapproved when not logged in" do
    get unapproved_properties_path
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect sold when not logged in" do
    get sold_properties_path
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect approve when not logged in" do
    assert_not @unapproved_property.approved?
    patch approve_property_path(@unapproved_property)
    assert_not @unapproved_property.reload.approved?
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect interested_users when not logged in" do
    get interested_users_property_path(@property)
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect mark_as_sold when not logged in" do
    assert_not @property.sold?
    patch mark_as_sold_property_path(@property)
    assert_not @property.sold?
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_property_path(@property)
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
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
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect destroy when logged in as wrong user" do
    log_in_as(@other_user)
    assert_no_difference 'Property.count' do
      delete property_path(@property)
    end
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect unapproved when logged in as a non-admin" do
    log_in_as(@other_user)
    get unapproved_properties_path
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect sold when logged in as a non-admin" do
    log_in_as(@other_user)
    get sold_properties_path
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect approve when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_not @unapproved_property.approved?
    patch approve_property_path(@unapproved_property)
    assert_not @unapproved_property.reload.approved?
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect interested_users when logged in as wrong user" do
    log_in_as(@other_user)
    get interested_users_property_path(@property)
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect mark_as_sold when logged in as wrong user" do
    log_in_as(@other_user)
    assert_not @property.sold?
    patch mark_as_sold_property_path(@property)
    assert_not @property.sold?
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect edit for sold property" do
    log_in_as(@user)
    get edit_property_path(@sold_property)
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect update for sold property" do
    log_in_as(@user)
    patch property_path(@sold_property),
          params: { property: { owner_name:      "ajay sharma",
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
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect destroy for sold property" do
    log_in_as(@user)
    assert_no_difference 'Property.count' do
      delete property_path(@sold_property)
    end
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect interested_users for unapproved property" do
    log_in_as(@user)
    get interested_users_property_path(@unapproved_property)
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect interested_users for sold property" do
    log_in_as(@user)
    get interested_users_property_path(@sold_property)
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect mark as sold for unapproved property" do
    log_in_as(@user)
    patch mark_as_sold_property_path(@unapproved_property)
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect mark as sold for sold property" do
    log_in_as(@user)
    patch mark_as_sold_property_path(@sold_property)
    assert_redirected_to root_url
    assert flash.empty?
  end
end