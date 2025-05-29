class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :confirm]

  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
  end

  def create
    @contact = Contact.new(contact_params)
      if @contact.save
      redirect_to root_path, notice: 'お問い合わせを送信しました。'
    else
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name)
  end
end
