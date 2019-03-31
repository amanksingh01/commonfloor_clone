require 'test_helper'

class UserShowTest < ActionDispatch::IntegrationTest

  def setup
    @admin         = users(:aman)
    @non_admin     = users(:barry)
    @other_user    = users(:kara)
    @inactive_user = users(:inactive)
  end

  test "should redirect to root_url when user not activated" do
    log_in_as(@admin)
    get user_path(@inactive_user)
    assert_redirected_to root_url
  end

  test "should display user when current user is user or admin" do
    log_in_as(@admin)
    # Visit own profile
    get user_path(@admin)
    assert_template 'users/show'
    assert_response :success
    # Visit other user's profile
    get user_path(@other_user)
    assert_template 'users/show'
    assert_response :success
  end

  test "should redirect non-admin user when visiting non-seller profile" do
    log_in_as(@non_admin)
    assert_not @other_user.seller?
    get user_path(@other_user)
    assert_redirected_to root_url
  end

  test "should display seller's profile" do
    log_in_as(@other_user)
    assert @admin.seller?
    get user_path(@admin)
    assert_template 'users/show'
    assert_response :success
  end
end
