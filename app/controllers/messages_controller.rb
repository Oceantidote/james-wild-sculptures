class MessagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      if message_params[:sign_up] == "1"
        gibbon = Gibbon::Request.new
        begin
          gibbon.lists(ENV['LIST_ID']).members.create(body: {email_address: @message.email, status: "subscribed"})
        rescue Gibbon::MailChimpError => e
        end
      end
      flash[:notice] = "Thanks for getting touch, James will get back to you as soon as possible"
      UserMailer.with(email: @message.email, phone: @message.phone, message: @message.message).contact.deliver_now
      if request.referrer.match(/messages/)
        redirect_to root_path
      elsif request.referrer.match(/contacts/)
        redirect_to new_contact_path
      else
        redirect_to(request.referrer)
      end

    else
      if request.referrer.match(/contacts/)
        render "contacts/new"
      else
        render :new
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:message, :email, :phone, :sign_up)
  end
end
