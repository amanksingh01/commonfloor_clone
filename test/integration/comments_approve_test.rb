require 'test_helper'

class CommentsApproveTest < ActionDispatch::IntegrationTest
  
  test "approve comments" do
    admin = users(:aman)
    log_in_as(admin)
    comment = comments(:unapproved)

    assert_not comment.approved?
    assert_nil comment.approved_at
    assert_nil comment.approved_by
    
    patch approve_comment_path(comment)
    
    assert comment.reload.approved?
    assert_not_nil comment.approved_at
    assert_equal admin, comment.approved_by
    assert_redirected_to unapproved_property_comments_path(comment.property)
    assert_not flash.empty?
  end
end