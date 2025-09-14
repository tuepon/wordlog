class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('CONTACT_RECIPIENT')
  layout 'mailer'
end
