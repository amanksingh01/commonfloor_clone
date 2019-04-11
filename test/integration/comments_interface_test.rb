require 'test_helper'

class CommentsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin      = users(:aman)
    @user       = users(:barry)
    @other_user = users(:kara)
    @property   = properties(:salt_lake)
  end

  test "comments interface" do
    log_in_as(@user)
    get property_path(@property)

    # Invalid submission
    assert_no_difference 'Comment.count' do
      post property_comments_path(@property), params: { 
                                                comment: { comment: "" } }
    end
    assert_select 'div#error_explanation'
    
    # Valid submission
    comment = "This comment is literally unimportant!"
    assert_difference 'Comment.count', 1 do
      post property_comments_path(@property), params: { 
                                               comment: { comment: comment } }
    end
    comment = assigns(:comment)
    assert_not comment.approved?
    assert_nil comment.approved_at
    assert_nil comment.approved_by
    assert_redirected_to @property
    follow_redirect!
    assert_select "div#comment-#{comment.id}", count: 0
    log_in_as(@admin)
    get property_path(@property)
    assert_select "div#comment-#{comment.id}"
    assert_match comment.comment, response.body

    # Approve comment
    comment.approve(@admin)
    assert comment.reload.approved?
    assert_not_nil comment.approved_at
    assert_equal @admin, comment.approved_by
    log_in_as(@user)
    get property_path(@property)
    assert_select "div#comment-#{comment.id}"
    assert_match comment.comment, response.body

    # Delete comment
    first_comment = assigns(:comments).first
    assert_select 'a[href=?]', comment_path(first_comment), text: 'Delete'
    assert_difference 'Comment.count', -1 do
      delete comment_path(first_comment)
    end

    # Login with a different user (no delete links)
    log_in_as(@other_user)
    get property_path(@property)
    assert_select 'a', text: 'Delete', count: 0
  end
end
