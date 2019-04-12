require 'test_helper'

class PropertiesWithUnapprovedCommentsPageTest < ActionDispatch::IntegrationTest
  
  test "properties_with_unapproved_comments_page" do
    log_in_as(users(:aman))
    get properties_with_unapproved_comments_path
    assert_template 'comments/properties_with_unapproved_comments'
    assert_template 'properties/_property'
    assert_select 'h2', text: 'Properties with unapproved comments'
    properties = assigns(:properties)
    assert_not properties.empty?
    properties.each do |property|
      count = property.comments.where(approved: false).count
      assert count > 0
      assert_select 'a[href=?]', unapproved_property_comments_path(property),
                    text: "View unapproved comments (#{count})"
    end
  end
end