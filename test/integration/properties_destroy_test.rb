require 'test_helper'

class PropertiesDestroyTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin    = users(:aman)
    @user     = users(:barry)
    @property = properties(:salt_lake)
  end

  test "successful destroy" do
    log_in_as(@user)
    assert_difference 'Property.count', -1 do
      delete property_path(@property)
    end
    assert_not flash.empty?
    assert_redirected_to @user
  end

  test "successful destroy by admin" do
    log_in_as(@admin)
    assert_difference 'Property.count', -1 do
      delete property_path(@property)
    end
    assert_not flash.empty?
    assert_redirected_to @user
  end
end
