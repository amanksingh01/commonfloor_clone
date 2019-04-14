require 'test_helper'

class IdentityTest < ActiveSupport::TestCase
  
  def setup
    @user     = users(:aman)
    @identity = @user.identities.build(uid: 'uid', provider: 'provider')
  end

  test "should be valid" do
    assert @identity.valid?
  end

  test "user_id should be present" do
    @identity.user_id = nil
    assert_not @identity.valid?
  end

  test "uid should be present" do
    @identity.uid = nil
    assert_not @identity.valid?
  end

  test "provider should be present" do
    @identity.provider = nil
    assert_not @identity.valid?
  end

  test "uid and provider combination should be unique" do
    # Same uid and provider
    duplicate_identity = @identity.dup
    @identity.save
    assert_not duplicate_identity.valid?

    # Different uid
    duplicate_identity.uid = 'different_uid'
    assert duplicate_identity.valid?
    
    # Different provider
    duplicate_identity.uid = @identity.uid
    duplicate_identity.provider = 'different_provider'
    assert duplicate_identity.valid?
  end
end
