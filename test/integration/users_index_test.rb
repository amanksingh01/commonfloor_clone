require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  include ActionView::Helpers::NumberHelper

  def setup
    @admin     = users(:aman)
    @non_admin = users(:barry)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    first_page_of_users = User.order(:created_at).paginate(page: 1)
    first_page_of_users.first.toggle!(:activated)
    get users_path
    assert_template 'shared/users'
    assert_select 'nav.pagination', count: 1
    assigns(:users).each do |user|
      assert user.activated?
      assert_match user.name,  response.body
      assert_match user.email, response.body
      assert_select "a[href=?]", "mailto:#{user.email}"
      mobile_number = number_to_phone(user.mobile_number,
                                      delimiter: " ",
                                      country_code: 91,
                                      pattern: /(\d{5})(\d{5})$/)
      assert_match mobile_number, response.body
      assert_select "a[href=?]", "tel:#{mobile_number}"
      assert_select 'a[href=?]', user_path(user), text: 'View profile'
      if user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'Delete', count: 0
      else
        assert_select 'a[href=?]', user_path(user), text: 'Delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "order should be oldest first" do
    log_in_as(@admin)
    get users_path
    assert_equal users(:oldest), assigns(:users).first
  end

  test "index as non-admin including links on interested_users page" do
    log_in_as(@non_admin)
    get users_path
    assert_redirected_to root_url
    property = properties(:salt_lake)
    get interested_users_property_path(property)
    assert_template 'shared/users'
    assert_template 'properties/_sell_form'
    interested_users = property.interested_users
    assert_select 'form[action=?]', sell_property_path(property),
                  count: interested_users.count
    assert_not interested_users.empty?
    interested_users.each do |user|
      assert_select 'input[type=submit][value=?]', "Sell to #{user.name}"
      assert_select 'a[href=?]', user_path(user), text: 'View profile', count: 0
      assert_select 'a[href=?]', user_path(user), text: 'Delete', count: 0
    end
  end
end
