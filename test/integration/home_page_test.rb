require 'test_helper'

class HomePageTest < ActionDispatch::IntegrationTest

  test "home page" do
    get root_path
    assert_template 'static_pages/home'
    assert_template 'static_pages/_home_page_properties'
    assert_template 'properties/_property'

    assert_select 'a[href=?]', properties_path(property_type: "apartment",
                                               order_by:      "desc")
    assert_select 'a[href=?]', properties_path(property_type: "house",
                                               order_by:      "desc")
    assert_select 'a[href=?]', properties_path(property_type: "plot",
                                               order_by:      "desc")
    
    apartments = Property.where(approved: true)
                         .where(sold: false)
                         .property_type("apartment")
                         .order_by("desc")
                         .take(4)
    houses     = Property.where(approved: true)
                         .where(sold: false)
                         .property_type("house")
                         .order_by("desc")
                         .take(4)
    plots      = Property.where(approved: true)
                         .where(sold: false)
                         .property_type("plot")
                         .order_by("desc")
                         .take(4)
    
    assert_equal apartments, assigns(:apartments)
    assert_equal houses,     assigns(:houses)
    assert_equal plots,      assigns(:plots)

    assert_select 'section.properties-stats h5', text: 'Properties Stats'
    assert_select 'section.properties-stats p',
      text: "Properties listed: #{Property.where(approved: true).count}"
    assert_select 'section.properties-stats p',
      text: "Properties sold: #{Property.where(sold: true).count}"
    assert_select 'section.visitors-stats p',
      text: "Visitors count: #{Visitor.visitors_count}"
  end
end