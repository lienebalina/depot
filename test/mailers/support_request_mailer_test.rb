require "test_helper"

class SupportRequestMailerTest < ActionMailer::TestCase
  test "respond" do
    support_request = SupportRequest.new(email: "to@example.org", subject: "Test Subject", body: "Test Body")

    mail = SupportRequestMailer.respond(support_request)
    assert_equal "Re: Test Subject", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Test Body", mail.body.encoded
  end

end
