require 'test_helper'

class PropertiesSoldTest < ActionDispatch::IntegrationTest
  
  test "mark properties as sold" do
    log_in_as(users(:aman))
    property = properties(:dum_dum)
    get property_path(property)
    assert_template 'properties/show'
    assert_not property.sold?
    patch mark_as_sold_property_path(property)
    assert property.reload.sold?
    assert_not flash.empty?
    assert_redirected_to property
  end
end
