class Restaurant < ActiveRecord::Base

  has_many :deals
  has_many :restaurant_users
  has_many :users, :through => :restaurant_users
  belongs_to :myOwner, :class_name => "User",
    :foreign_key => "user_id"
  before_save :downcase_subdomain

  def downcase_subdomain
    self.subdomain.downcase!
  end

  def subscribe(user, email, sms)
    restaurant_users.build({user: user, sms: sms?, email: email?, date_joined: Time.now}).save
  end

  def update_subscription(user, email, sms)
    subscription = restaurant_users.where(user: user)
    subscription.email = email?
    subscription.sms = sms?
    subscription.save
  end

  def delete_subscription(user)
      subscription = restaurant_users.where(user: user)
      subscription.destroy
  end

  def most_recent_deal
    most_recent_deal = deals.order("end_on DESC").first
  end

  def current_deal
    if most_recent_deal && most_recent_deal.before_end?
      most_recent_deal
    else
      nil
    end
  end

  def twitter_confirmed?
    twitter_handle.present? && twitter_token.present? && twitter_secret.present?
  end

  def remove_twitter
    self.twitter_handle = nil
    self.twitter_token = nil
    self.twitter_secret = nil
    self.save
  end

end
