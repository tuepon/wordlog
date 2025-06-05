class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('CONTACT_TEST_RECIPIENT', 'support@example.com')
  layout 'mailer'
end
