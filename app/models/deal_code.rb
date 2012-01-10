class DealCode < ActiveRecord::Base

  belongs_to :deal
  belongs_to :transaction

  def has_been_purchased?
    transaction.present?
  end

  def to_s
    code
  end

end
