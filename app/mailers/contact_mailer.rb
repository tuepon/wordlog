class ContactMailer < ApplicationMailer
  def mail_to_user(contact_id)
    @contact = Contact.find(contact_id)
    mail(to: @contact.email, subject: 'お問い合わせありがとうございます')
  end
end
