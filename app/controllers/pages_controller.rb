class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about, :contact]

  def home
    @homepage = Homepage.first
    @projects = Project.where(featured: true).last(9).reverse
  end

  def about
  end

  def subscribe
    gibbon = Gibbon::Request.new
    begin
      gibbon.lists(ENV['LIST_ID']).members.create(body: {email_address: params[:email][:address], status: "subscribed"})
      flash[:notice] = "Thanks for signing up to the mailing list"
    rescue Gibbon::MailChimpError => e
      if e.title == "Member Exists"
        flash[:alert] = "You are already signed up to the mailing list"
      else
        flash[:alert] = "I'm sorry, it seems something went wrong with your signup, please try again"
      end
    end
    redirect_to request.referrer
  end

  def contact
  end
end
