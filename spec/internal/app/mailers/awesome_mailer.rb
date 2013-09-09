class AwesomeMailer < ActionMailer::Base
  default from: 'no-reply@example.com'

  def welcome
    mail(
      to: "text@example.com",
      body: "Hello",
      subject: "We like to spamalot!"
    )
  end
end