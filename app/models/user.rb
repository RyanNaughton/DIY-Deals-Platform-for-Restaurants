class User < ActiveRecord::Base

  has_secure_password

  has_many :transactions
  has_many :restaurant_users
  has_many :restaurants, :through => :restaurant_users
  has_one :myRestaurant, :class_name => "Restaurant",
                         :foreign_key => "user_id"

  before_validation :remove_nondigits_in_phone
  before_save :create_email_confirmation_code, :if => Proc.new{ email_changed? || email_was.nil? }
  before_save :downcase_email, :if => Proc.new{ email_changed? || email_was.nil? }
  after_create :send_confirmations

  validates :email, :presence => true, :uniqueness => true
  validates :password_digest, :presence => true
  validates_format_of :email, :with => /^\S+@(?:[-a-z0-9]+\.)+[-a-z0-9]{2,}$/i
  validates_format_of :phone, :with => /^1?\d{10}$/, :if => "phone.present?"

  def is_restaurant_owner?
    myRestaurant.present?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def remove_nondigits_in_phone
    if phone.present?
      phone.gsub!(/\D/, '')
    end
  end

  def create_email_confirmation_code
    self.email_confirmation_code = (0...8).map{65.+(rand(25)).chr}.join
  end

  def downcase_email
    self.email = email.downcase
  end

  def send_confirmations
    UserMailer.confirm_email(self).deliver
    if phone
      body = "Thanks for signing up for restaurant deals! Reply to confirm"
      TwilioSender.send_sms(Restaurant.first, phone, body)
    end
  end

end
