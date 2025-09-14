class ContactMailer < ApplicationMailer
  # For support
  def mail_to_support(contact_id)
    @contact = Contact.find(contact_id)
    mail(
      to: ENV.fetch('CONTACT_TO', 'support@webisle.net'),
      subject: "[webisle.net] 新しいお問い合わせ: #{@contact.name} 様"
    )
  end

  # For user
  def confirmation_to_user(contact_id)
    @contact = Contact.find(contact_id)
    mail(
      to: @contact.email,
      subject: '[webisle.net] お問い合わせを受け付けました'
    )
  end
end
