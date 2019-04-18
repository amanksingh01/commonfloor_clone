require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  
  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should redirect new if the user is already logged in" do
    log_in_as(users(:aman))
    get login_path
    assert_redirected_to root_url
    assert_not flash.empty?
  end

  test "should redirect create if the user is already logged in" do
    log_in_as(users(:aman))
    post login_path, params: { session: { email:    "aman@example.com",
                                          password: "password" } }
    assert_redirected_to root_url
    assert_not flash.empty?
  end
end
