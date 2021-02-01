class MessagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create]

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
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
    params.require(:message).permit(:message, :email, :phone)
  end
end
