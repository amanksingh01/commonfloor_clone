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
    count = User.where(activated: true).count
    assert_select 'a[href=?]', users_path, text: "List all users (#{count})"
    count = User.where(seller: true).count
    assert_select 'a[href=?]', sellers_path, text: "List all sellers (#{count})"

    assert_select 'h5.card-header', text: 'Properties actions'
    count = Property.where(approved: true).count
    assert_select 'a[href=?]', properties_path,
                  text: "List all properties (#{count})"
    count = Property.where(sold: true).count
    assert_select 'a[href=?]', sold_properties_path,
                  text: "List all sold properties (#{count})"
    count = Property.where(approved: false).count
    assert_select 'a[href=?]', unapproved_properties_path,
                  text: "List all unapproved properties (#{count})"

    assert_select 'h5.card-header', text: 'Comments actions'
    count = Property.joins(:comments)
                    .where(comments: { approved: false })
                    .distinct
                    .count
    assert_select 'a[href=?]', properties_with_unapproved_comments_path,
                  text: "List all unapproved comments (#{count})"
  end
end
