require 'test_helper'

class PropertiesIndexTest < ActionDispatch::IntegrationTest
  include ActionView::Helpers::DateHelper
  
  test "properties index including filters" do
    get properties_path
    assert_template 'properties/index'
    assert_template 'shared/_filters'
    assert_select 'aside.filters form[action=?]', properties_path
    assert_select 'nav.pagination', count: 1
    first_page_of_properties = assigns(:properties)
    assert_not first_page_of_properties.empty?
    first_page_of_properties.each do |property|
      assert property.approved?
      assert_not property.sold?
      assert_match  (property.bed_rooms == 'na' ? property.area.to_s :
                                                  property.bed_rooms.upcase),
                    response.body
      assert_match  property.property_type.capitalize,      response.body
      assert_match  property.property_status.capitalize,    response.body
      assert_match  property.locality.titleize,             response.body
      assert_match  property.city.titleize,                 response.body
      assert_match  property.price.to_s,                    response.body
      assert_match  time_ago_in_words(property.created_at), response.body
      assert_select 'a[href=?]', property_path(property), text: 'View details'
    end

    # Apply filters
    get properties_path(property_type: "apartment", include_sold: "yes")
    first_page_of_properties = assigns(:properties)
    assert_not first_page_of_properties.empty?
    first_page_of_properties.each do |property|
      assert_equal "apartment", property.property_type
    end
    assert_select 'h2.sold-tag', text: 'Sold'
  end
end
