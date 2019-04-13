require 'test_helper'

class BoughtPropertiesPageTest < ActionDispatch::IntegrationTest
  
  test "bought properties page" do
    buyer = users(:oliver)
    log_in_as(buyer)
    get bought_properties_user_path(buyer)
    assert_template 'users/bought_properties'
    assert_template 'properties/_property'
    assert_select 'h2', text: 'Bought properties'
    assert_select 'h2.sold-tag', text: 'Sold', count: 0
    
    bought_properties = assigns(:properties)
    assert_not bought_properties.empty?
    assert_equal properties(:sold_oldest), bought_properties.first
    bought_properties.each do |property|
      assert         property.sold?
      assert_not_nil property.sold_at
      assert_equal   buyer, property.buyer
      assert_select 'a[href=?]', property_path(property)
    end
  end
end
