require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "welcome user" do
    user = users(:one)
    mail = UserMailer.welcome(user)

    assert_equal "Welcome #{user.name} to The Pragmatic Bookshelf", mail.subject
    assert_equal [user.email], mail.to
    assert_equal [ADMIN_EMAIL], mail.from
    assert_match /Welcome/, mail.body.encoded
  end
end
