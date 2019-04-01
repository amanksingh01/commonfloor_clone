require 'test_helper'

class SoldPropertiesPageTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:aman)
    log_in_as(@user)
  end

  test "sold properties page" do
    get sold_properties_path
    assert_template 'properties/sold'
    assert_template 'properties/_property'
    
    properties = assigns(:properties)
    assert_not properties.empty?
    assert_select 'h2.sold-tag', text: 'Sold', count: properties.count
    properties.each do |property|
      assert property.sold?
    end
  end

  test "order should be oldest first" do
    get sold_properties_path
    assert_equal properties(:sold_oldest), assigns(:properties).first
  end
end
