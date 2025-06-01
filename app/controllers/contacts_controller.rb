class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :confirm, :complete]

  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    unless @contact.valid?
      render :new
    end
  end

  def create
    if params[:back]
      @contact = Contact.new(contact_params)
      render :new and return
    end

    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to complete_contacts_path
    else
      render :new
    end
  end

  def complete
    @contact = Contact.find_by(id: session[:session_id])
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :telephone, :body)
  end
end
