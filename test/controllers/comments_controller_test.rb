require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @comment  = comments(:two)
    @property = @comment.property
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Comment.count' do
      post property_comments_path(@property),
           params: { comment: { comment: "Lorem ipsum", user: users(:aman) } }
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Comment.count' do
      delete comment_path(@comment)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy for wrong comment" do
    log_in_as(users(:barry))
    assert_no_difference 'Comment.count' do
      delete comment_path(@comment)
    end
    assert_redirected_to root_url
  end
end