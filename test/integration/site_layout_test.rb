require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @admin     = users(:aman)
    @non_admin = users(:barry)
  end
  
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", properties_path
    assert_select "a[href=?]", new_property_path
    log_in_as(@non_admin)
    get root_path
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", favorites_user_path(@non_admin)
    assert_select "a[href=?]", user_path(@non_admin)
    assert_select "a[href=?]", edit_user_path(@non_admin)
    log_in_as(@admin)
    get root_path
  end
end
