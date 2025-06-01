class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :confirm, :complete]

  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    unless @contact.valid?
      render :new and return
    end
  end

  def create
    @contact = Contact.new(contact_params)
      return render :new if params[:button] == 'back'
      if @contact.save
        redirect_to complete_contacts_url, notice: 'お問い合わせを送信しました。'
      else
        render :confirm
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :telephone, :body)
  end
end
