class Deal < ActiveRecord::Base

  has_many :transactions
  belongs_to :restaurant
  has_many :deal_codes
  belongs_to :deal_template

  before_create :create_deal_codes
  before_validation :set_delivery_time, :if => Proc.new{ delivery_time.nil? }
  before_validation :make_active
  before_validation :set_deal_template, :if => Proc.new{deal_template.nil?}

  validates :discounted_price, :start_on, :end_on, :active, :delivery_time, :quantity, :deal_template_id, :restaurant_id, :presence => true


  def quantity_sold
    transactions.reduce(0){|sum,x| sum + x.quantity }
  end

  def quantity_remaining
    quantity - quantity_sold
  end

  def any_left?
    quantity_remaining >= 1
  end

  def sold_out?
    not any_left?
  end

  def before_end?
    Time.now < end_on
  end

  def can_be_bought?
    any_left? && before_end?
  end

  def deal_day_and_time_range
    day = deal_tonight_or_tomorrow
    format_time = ->(t) { t.in_time_zone("Central Time (US & Canada)").strftime("%l:%M%P") }
    "#{day} from #{format_time[start_on]} to #{format_time[end_on]}"
  end

  def deal_tonight_or_tomorrow
    if start_on.in_time_zone("Central Time (US & Canada)").strftime("%d") == Time.now.in_time_zone("Central Time (US & Canada)").strftime("%d")
      "tonight"
    else
      "tomorrow"
    end
  end

  def deal_discounted_price
    #CurrencyConverter.currencify(discounted_price)
    "$#{discounted_price / 100}"
  end

  def deal_original_price
    #CurrencyConverter.currencify(original_price)
    "$#{original_price / 100}"
  end

  def deal_string
      eval(deal_template.text_description)
  end

  def deal_html
      eval(deal_template.html_description)
  end


private

  def create_deal_codes
      quantity.times do
        deal_codes.build({:code => (0...6).map{65.+(rand(25)).chr}.join})
      end
  end

  def set_delivery_time
    self.delivery_time = Time.now
  end

  def set_deal_template
    self.deal_template = DealTemplate.first
  end

  def make_active
    self.active = true
  end

# Once I add additional deal templates, each deal will require different validations depending on its corresponding template

#  with_options :if => "template_id == 2" do |this|
#    this.validates :product, :presence => true
#    this.validates ...
#  end

#  with_options :if => "template_id == 3" do |this|
#    this.validates :product, :presence => true
#    this.validates ...
#  end

#  with_options :if => "template_id == 4" do |this|
#    this.validates :product, :presence => true
#    this.validates ...
#  end

end
