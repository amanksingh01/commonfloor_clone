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
    assert_select 'h4', text: "Welcome to CommonfloorClone, #{@user.name}"
    assert_select 'h4>img.gravatar'
    assert_match assigns(:title), response.body
    assert_template 'shared/_properties'
    assert_template 'shared/_filters'
    assert_select 'aside.filters form[action=?]', user_path(@user)
    assert_select 'nav.pagination', count: 1
  end
end
