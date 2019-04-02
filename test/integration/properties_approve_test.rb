require 'test_helper'

class PropertiesApproveTest < ActionDispatch::IntegrationTest
  
  test "approve properties" do
    admin = users(:aman)
    log_in_as(admin)
    property = properties(:unapproved)

    assert_not property.approved?
    assert_nil property.approved_at
    assert_nil property.approved_by
    
    patch approve_property_path(property)
    
    assert property.reload.approved?
    assert_not_nil property.approved_at
    assert_equal admin, property.approved_by
    assert_redirected_to property_path(property)
    assert_not flash.empty?
  end
end
