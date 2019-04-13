require 'test_helper'

class PropertySellTest < ActionDispatch::IntegrationTest
  
  test "property sell" do
    log_in_as(users(:aman))
    property = properties(:dum_dum)
    get property_path(property)
    assert_template 'properties/show'
    
    assert_not property.sold?
    buyer = users(:barry)
    
    patch sell_property_path(property), params: { buyer_id: buyer.id }
    
    assert         property.reload.sold?
    assert_not_nil property.sold_at
    assert_equal   buyer, property.buyer
    
    assert_not flash.empty?
    assert_redirected_to property
  end
end
