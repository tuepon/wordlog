class ContactMailer < ApplicationMailer
  def mail_to_user(contact_id)
    @contact = Contact.find(contact_id)
    mail(
      to: ENV.fetch('CONTACT_RECIPIENT', @contact.email),
      subject: "お問い合わせ: #{@contact.name} 様"
    )
  end
end
