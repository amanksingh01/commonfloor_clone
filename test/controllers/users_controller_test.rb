require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user       = users(:aman)
    @other_user = users(:barry)
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect index when logged in as a non-admin" do
    log_in_as(@other_user)
    get users_path
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect show when not logged in" do
    get user_path(@user)
    assert_redirected_to login_url
    assert_not flash.empty?
  end
  
  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: {
                              user: { name: @user.name,
                                      email: @user.email,
                                      mobile_number: @user.mobile_number } }
    assert_redirected_to login_url
    assert_not flash.empty?
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

  test "should redirect new if the user is already logged in" do
    log_in_as(users(:aman))
    get signup_path
    assert_redirected_to root_url
    assert_not flash.empty?
  end

  test "should redirect create if the user is already logged in" do
    log_in_as(users(:aman))
    assert_no_difference 'User.count', 1 do
      post signup_path, params: { user: { name:  "Example User",
                                          email: "user@example.com",
                                          mobile_number: "9876543210",
                                          password:              "password",
                                          password_confirmation: "password" } }
    end
    assert_redirected_to root_url
    assert_not flash.empty?
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: {
                              user: { name: @user.name,
                                      email: @user.email,
                                      mobile_number: @user.mobile_number } }
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "User.count" do
      delete user_path(@user)
    end
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference "User.count" do
      delete user_path(@user)
    end
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect destroy on trying to destroy an admin user" do
    log_in_as(@user)
    assert_no_difference "User.count" do
      delete user_path(@user)
    end
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect favorites when not logged in" do
    get favorites_user_path(@user)
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect favorites when logged in as wrong user" do
    log_in_as(@other_user)
    get favorites_user_path(@user)
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect bought_properties when not logged in" do
    get favorites_user_path(@user)
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect bought_properties when logged in as wrong user" do
    log_in_as(@other_user)
    get bought_properties_user_path(@user)
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect admin when not logged in" do
    get admin_path
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect admin when logged in as a non-admin" do
    log_in_as(@other_user)
    get admin_path
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect sellers when not logged in" do
    get sellers_path
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect sellers when logged in as a non-admin" do
    log_in_as(@other_user)
    get sellers_path
    assert_redirected_to root_url
    assert flash.empty?
  end
end