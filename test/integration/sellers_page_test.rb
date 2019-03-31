require 'test_helper'

class SellersPageTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:aman)
    log_in_as(@user)
  end
  
  test "sellers page" do
    get sellers_path
    assert_template 'shared/users'
    assert_select 'h2', text: 'Sellers'

    users = assigns(:users)
    assert_not users.empty?
    users.each do |user|
      assert user.seller?
    end
  end

  test "order should be oldest first" do
    get sellers_path
    assert_equal @user, assigns(:users).first
  end
end
