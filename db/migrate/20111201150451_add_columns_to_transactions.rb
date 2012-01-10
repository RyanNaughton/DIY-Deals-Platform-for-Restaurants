class AddColumnsToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :quantity, :integer
    add_column :transactions, :braintree_id, :integer
    add_column :restaurant_customers, :sms, :boolean
    add_column :restaurant_customers, :email, :boolean
  end
end
