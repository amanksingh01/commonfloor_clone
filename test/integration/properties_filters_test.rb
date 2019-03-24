require 'test_helper'

class PropertiesFiltersTest < ActionDispatch::IntegrationTest
  
  test "properties filters" do
    get properties_path
    assert_template 'properties/index'
    assert_template 'shared/_properties'
    assert_template 'shared/_filters'
    assert_template 'shared/_filters_form'
    assert_select 'h5', text: "Filters"
    property_type   = "apartment"
    property_status = "sell"
    bed_rooms       = "4bhk"
    area            = "2"
    price           = "4"
    order_by        = "desc"
    get properties_path, params: { property_type:   property_type,
                                   property_status: property_status,
                                   bed_rooms:       bed_rooms,
                                   area:            area,
                                   price:           price,
                                   order_by:        order_by }
    properties = assigns(:properties)
    assert_not properties.empty?
    assert_equal properties(:most_recent), properties.first
    properties.each do |property|
      assert_equal property_type,   property.property_type
      assert_equal property_status, property.property_status
      assert_equal bed_rooms,       property.bed_rooms
      assert_includes 1000..2500, property.area
      assert property.price > 5000000
    end
  end
end
