class DealMailer < ActionMailer::Base

  default from: "ryan@simplebanana.com"
  
  def send_deal(subscription, deal)
    @subscription = subscription
    @deal = deal
    mail(:to => @subscription.user.email, 
         :subject => @deal.deal_string,
         :from => "#{@deal.restaurant.subdomain}@simplebanana.com")
  end

end

