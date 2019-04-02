require 'test_helper'

class UnapprovedPropertiesPageTest < ActionDispatch::IntegrationTest
  
  test "unapproved properties page" do
    log_in_as(users(:aman))
    get unapproved_properties_path
    assert_template 'properties/unapproved'
    assert_template 'shared/_filters'
    assert_select 'h5.unapproved-tag',
                  text: 'Pending approval',
                  count: Property.where(approved: false).count
    properties = assigns(:properties)
    assert_not properties.empty?
    properties.each do |property|
      assert_not property.approved?
      assert_nil property.approved_at
      assert_nil property.approved_by
    end
  end
end
