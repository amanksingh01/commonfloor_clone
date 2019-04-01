require 'test_helper'

class AdminPageTest < ActionDispatch::IntegrationTest
  
  test "admin page with friendly forwarding" do
    get admin_path
    assert_not session[:forwarding_url].nil?
    assert_redirected_to login_url
    log_in_as(users(:aman))
    assert_redirected_to admin_path
    follow_redirect!
    assert_template 'users/admin'
    assert_select 'h2', text: 'Admin panel'

    assert_select 'h5.card-header', text: 'Users actions'
    assert_select 'a[href=?]', users_path,
                  text: "List all users (#{User.where(activated: true).count})"
    assert_select 'a[href=?]', sellers_path,
                  text: "List all sellers (#{User.where(seller: true).count})"

    assert_select 'h5.card-header', text: 'Properties actions'
    assert_select 'a[href=?]', properties_path,
                  text: "List all properties (#{Property.count})"
    assert_select 'a[href=?]', sold_properties_path,
      text: "List all sold properties (#{Property.where(sold: true).count})"
    assert_select 'a[href=?]', '#',
                  text: 'List all unapproved properties'

    assert_select 'h5.card-header', text: 'Comments actions'
    assert_select 'a[href=?]', '#',
                  text: 'List all unapproved comments'
  end
end
