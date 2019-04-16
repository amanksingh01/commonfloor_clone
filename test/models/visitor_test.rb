require 'test_helper'

class VisitorTest < ActiveSupport::TestCase
  
  def setup
    @visitor = Visitor.new(remote_ip: "127.0.0.1")
  end

  test "should be valid" do
    assert @visitor.valid?
  end

  test "remote_ip should be present" do
    @visitor.remote_ip = "   "
    assert_not @visitor.valid?
  end

  test "remote_ip should be unique" do
    duplicate_visitor = @visitor.dup
    @visitor.save
    assert_not duplicate_visitor.valid?
  end
end
