class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :sent]

  def index
    @contacts = Contact.all
  end

  def new
    @contact = Contact.new
    @message = Message.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.sent = false
    @contact.save
    redirect_to new_contact_path
    flash[:notice] = "Thanks for your request, a brochure will be with you soon."
  end

  def sent
    @contact = Contact.find(params[:id])
    @contact.sent = true
    if @contact.save
      redirect_to contacts_path
    else
      flash[:error] = 'Something went wrong'
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :id)
  end
end
