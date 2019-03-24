require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin     = users(:aman)
    @non_admin = users(:barry)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.first.toggle!(:activated)
    get users_path
    assert_template 'shared/users'
    assert_select 'nav.pagination', count: 1
    assigns(:users).each do |user|
      assert user.activated?
      assert_match user.name,          response.body
      assert_match user.email,         response.body
      assert_match user.mobile_number, response.body
      assert_select 'a[href=?]', user_path(user), text: 'View profile'
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'Delete user'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin including links on interested_users page" do
    log_in_as(@non_admin)
    get users_path
    assert_redirected_to root_url
    property = properties(:salt_lake)
    get interested_users_property_path(property)
    assert_template 'shared/users'
    property.interested_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: 'View profile'
      assert_select 'a[href=?]', user_path(user), text: 'Delete user', count: 0
    end
  end
end
