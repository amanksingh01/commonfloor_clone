require 'test_helper'

class PropertiesSearchTest < ActionDispatch::IntegrationTest
  
  test "properties search including filters" do
    get search_path(q: "delhi")
    assert_template 'properties/search'
    assert_template 'shared/_filters'
    assert_select 'aside.filters form[action=?]', search_path
    assert_select "aside.filters input[type=hidden][name=q][value=delhi]"
    properties = assigns(:properties)
    assert_not properties.empty?
    properties.each do |property|
      assert_equal "new delhi", property.city
    end
    # Apply filters
    get search_path(q: "delhi", bed_rooms: "3bhk")
    properties = assigns(:properties)
    assert_not properties.empty?
    properties.each do |property|
      assert_equal "3bhk", property.bed_rooms
    end
  end
end
