module TwitterUpdater

  require 'twitter'

  def self.tweet(deal)
    Twitter.configure do |config|
      config.consumer_key = "xxx"
      config.consumer_secret = "xxx"
      config.oauth_token = deal.restaurant.twitter_token
      config.oauth_token_secret = deal.restaurant.twitter_secret
    end

    Twitter.update(deal.deal_string[0...140]+" http://cacafe.simplebanana.com/" )
  end


end

