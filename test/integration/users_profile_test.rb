require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:aman)
  end

  test "profile display" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h5', text: @user.name
    assert_select 'h5>img.gravatar'
    assert_match assigns(:title), response.body

    assert @user.seller?
    assert_select 'h2', text: 'Properties'
    assert_template 'shared/_properties'
    assert_template 'shared/_filters'
    assert_select 'aside.filters form[action=?]', user_path(@user)
    assert_select 'nav.pagination', count: 1
    properties = assigns(:properties)
    assert_not properties.empty?
    properties.each do |property|
      assert_not property.sold?
      assert_equal @user, property.user
    end
    
    # Apply filters
    get user_path(@user, property_type: "apartment", include_sold:  "yes")
    properties = assigns(:properties)
    assert_not properties.empty?
    properties.each do |property|
      assert_equal "apartment", property.property_type
    end
    assert_select 'h2.sold-tag', text: 'Sold'
  end
end
