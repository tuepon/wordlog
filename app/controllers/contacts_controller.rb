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
    @contact = Contact.new(contact_params)
    return render :new if params[:button] == 'back'

    if @contact.save
      ContactMailer.mail_to_user(@contact.id).deliver_now

      session[:contact_id] = @contact.id
      return redirect_to complete_contacts_path
    end

    render :confirm
  end

  def complete
    @contact = Contact.find_by(id: session[:session_id])
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :telephone, :body)
  end
end
