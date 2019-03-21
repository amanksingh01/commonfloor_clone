require 'test_helper'

class CommentsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @property = properties(:salt_lake)
  end

  test "comments interface" do
    log_in_as(users(:barry))
    get property_path(@property)
    # Invalid submission
    assert_no_difference 'Comment.count' do
      post comments_path, params: { property_id: @property.id, 
                                    comment: { comment: "" } }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    comment = "This comment is literally unimportant!"
    assert_difference 'Comment.count', 1 do
      post comments_path, params: { property_id: @property.id,
                                    comment: { comment: comment } }
    end
    assert_redirected_to @property
    follow_redirect!
    assert_match comment, response.body
    # Delete post
    first_comment = @property.comments.paginate(page: 1).first
    assert_select 'a[href=?]', comment_path(first_comment), text: 'Delete'
    assert_difference 'Comment.count', -1 do
      delete comment_path(first_comment)
    end
    # Login with a different user (no delete links)
    log_in_as(users(:kara))
    get property_path(@property)
    assert_select 'a', text: 'Delete', count: 0
  end
end
