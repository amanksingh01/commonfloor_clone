require 'test_helper'

class HomePageTest < ActionDispatch::IntegrationTest

  test "home page" do
    get root_path
    assert_template 'static_pages/home'
    assert_template 'static_pages/_home_page_properties'
    assert_template 'properties/_property'
    assert_select 'a[href=?]', properties_path(property_type: "apartment")
    assert_select 'a[href=?]', properties_path(property_type: "house")
    assert_select 'a[href=?]', properties_path(property_type: "plot")
    apartments = Property.property_type("apartment").order_by("desc").take(4)
    houses     = Property.property_type("house").order_by("desc").take(4)
    plots      = Property.property_type("plot").order_by("desc").take(4)
    assert_equal apartments, assigns(:apartments)
    assert_equal houses,     assigns(:houses)
    assert_equal plots,      assigns(:plots)
  end
end
