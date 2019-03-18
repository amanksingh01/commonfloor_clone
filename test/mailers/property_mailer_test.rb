require 'test_helper'

class PropertyMailerTest < ActionMailer::TestCase
  
  test "interested_user" do
    property = properties(:new_town)
    seller = property.user
    user = users(:aman)
    mail = PropertyMailer.interested_user(property, user)
    assert_equal "#{user.name} is interested in your property", mail.subject
    assert_equal [seller.email], mail.to
    assert_equal ["noreply@commonfloorclone.herokuapp.com"], mail.from
    assert_match seller.name,        mail.body.encoded
    assert_match user.name,          mail.body.encoded, count: 2
    assert_match user.email,         mail.body.encoded
    assert_match user.mobile_number, mail.body.encoded
  end
end