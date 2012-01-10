class TransactionMailer < ActionMailer::Base
  default from: "ryan@simplebanana.com"

  def send_purchase_confirmation(transaction)
    @transaction = transaction
    mail(:to => @transaction.user.email, 
         :subject => "Thank you for buying a deal from #{@transaction.deal.restaurant.subdomain}",
         :from => "#{@transaction.deal.restaurant.subdomain}@simplebanana.com")
  end

end
