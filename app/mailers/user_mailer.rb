class UserMailer < ApplicationMailer

  def contact
    @email = params[:email]
    @phone = params[:phone]
    @message = params[:message]

    mail to: "jamie1wild@googlemail.com"
  end
end
