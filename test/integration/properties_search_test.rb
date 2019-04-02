require 'test_helper'

class PropertiesSearchTest < ActionDispatch::IntegrationTest
  
  test "properties search including filters" do
    get search_path(q: "delhi")
    assert_template 'properties/search'
    assert_template 'shared/_filters'
    assert_select 'aside.filters form[action=?]', search_path
    assert_select 'aside.filters input[type=hidden][name=q][value=delhi]'
    properties = assigns(:properties)
    assert_not properties.empty?
    properties.each do |property|
      assert property.approved?
      assert_not property.sold?
      assert_equal "new delhi", property.city
    end
    # Apply filters
    get search_path(q: "kolkata", property_type: "apartment",
                                  include_sold: "yes")
    properties = assigns(:properties)
    assert_not properties.empty?
    properties.each do |property|
      assert_equal "apartment", property.property_type
    end
    assert_select 'h2.sold-tag', text: 'Sold'
  end
end
