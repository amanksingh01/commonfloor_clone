require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  
  def setup
    @comment = users(:aman).comments.build(property: properties(:salt_lake), 
                                           comment: "Lorem ipsum")
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "property id should be present" do
    @comment.property_id = nil
    assert_not @comment.valid?
  end

  test "user id should be present" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end

  test "comment should be present" do
    @comment.comment = "   "
    assert_not @comment.valid?
  end

  test "comment should be at most 255 characters" do
    @comment.comment = "a" * 256
    assert_not @comment.valid?
  end

  test "order should be most recent first" do
    assert_equal comments(:most_recent), Comment.first
  end
end