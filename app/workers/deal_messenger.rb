class DealMessenger
  @queue = :messages_queue

  def self.perform(deal_id)
    deal = Deal.find(deal_id)
    TwitterUpdater.tweet(deal) if deal.restaurant.twitter_confirmed?
		deal.restaurant.restaurant_users.each do |subscription|
			DealMailer.send_deal(subscription, deal).deliver if (subscription.email? && subscription.user.email_confirmed?)
			TwilioSender.send_sms(subscription.restaurant,subscription.user.phone, deal.deal_string) if (subscription.sms? && subscription.user.phone_confirmed?)
 		end
  end

end
