class Transaction < ActiveRecord::Base

  belongs_to :deal
  belongs_to :user
  has_one :deal_code
  
  validate :deal_cannot_be_nil,:deal_cannot_be_soldout, :deal_still_active

  before_validation :set_quantity, :if => Proc.new{quantity.nil?}
  before_create :set_deal_code
  after_create :send_transaction_alert

  validates :user, :deal, :quantity, :presence => true

  def set_quantity
    self.quantity = 1
  end

  def set_deal_code
    self.deal_code = deal.deal_codes.where(:transaction_id => nil).first
  end

  def self.create_from_restaurant_user(user, restaurant)
    deal = restaurant.most_recent_deal
    Transaction.create deal: deal, user: user
  end
  
  private
 
  def send_transaction_alert
    TransactionMailer.send_purchase_confirmation(self).deliver
  end
 
  def deal_cannot_be_nil
    if deal.nil?
      errors.add(:deal, "can't be nil")
    end
  end
  
  def deal_cannot_be_soldout
    if deal.sold_out?
      errors.add(:deal, "can't be soldout")
    end
  end
  
  def deal_still_active
    if !deal.before_end?
      errors.add(:deal, "has expired")
    end
  end

end
