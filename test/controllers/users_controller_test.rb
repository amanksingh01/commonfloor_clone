require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user       = users(:aman)
    @other_user = users(:barry)
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect index when logged in as a non-admin" do
    log_in_as(@other_user)
    get users_path
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect show when not logged in" do
    get user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: {
                              user: { name: @user.name,
                                      email: @user.email,
                                      mobile_number: @user.mobile_number } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)
    assert_not @other_user.admin?
    patch user_path(@other_user), params: {
                                    user: { password:              "password",
                                            password_confirmation: "password",
                                            admin: true } }
    assert_not @other_user.reload.admin?
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: {
                              user: { name: @user.name,
                                      email: @user.email,
                                      mobile_number: @user.mobile_number } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "User.count" do
      delete user_path(@user)
    end
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference "User.count" do
      delete user_path(@user)
    end
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect favorites when not logged in" do
    get favorites_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect favorites when logged in as wrong user" do
    log_in_as(@other_user)
    get favorites_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect admin when not logged in" do
    get admin_path
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect admin when logged in as a non-admin" do
    log_in_as(@other_user)
    get admin_path
    assert flash.empty?
    assert_redirected_to root_url
  end
end
