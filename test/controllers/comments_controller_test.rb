require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @comment   = comments(:two)
    @property  = @comment.property
    @non_admin = users(:barry)
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

  test "should redirect properties_with_unapproved_comments when not logged in" do
    get properties_with_unapproved_comments_path
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect properties_with_unapproved_comments when logged in as a non-admin" do
    log_in_as(@non_admin)
    get properties_with_unapproved_comments_path
    assert_redirected_to root_url
    assert flash.empty?
  end

  test "should redirect unapproved when not logged in" do
    get unapproved_property_comments_path(@property)
    assert_redirected_to login_url
    assert_not flash.empty?
  end

  test "should redirect unapproved when logged in as a non-admin" do
    log_in_as(@non_admin)
    get unapproved_property_comments_path(@property)
    assert_redirected_to root_url
    assert flash.empty?
  end
end