require 'test_helper'

class UnapprovedPropertyCommentsPageTest < ActionDispatch::IntegrationTest
  
  test "unapproved_property_comments_page" do
    log_in_as(users(:aman))
    property = properties(:salt_lake)
    get unapproved_property_comments_path(property)
    assert_template 'comments/unapproved'
    assert_template 'comments/_comment'
    assert_select 'h2', text: 'Unapproved comments'
    assert_select 'a[href=?]', property_path(property),
                  text: 'View property details'
    comments = assigns(:comments)
    assert_not comments.empty?
    comments.each do |comment|
      assert_not comment.approved?
      assert_select 'a[href=?]', '#',
                    text: 'Approve'
      assert_select 'a[href=?]', comment_path(comment),
                    text: 'Delete'
    end
  end
end
