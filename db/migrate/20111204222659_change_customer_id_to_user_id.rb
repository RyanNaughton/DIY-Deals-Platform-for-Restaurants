class ChangeCustomerIdToUserId < ActiveRecord::Migration

  def change
    rename_column :transactions, :customer_id, :user_id
    rename_column :restaurant_customers, :customer_id, :user_id
    rename_table :restaurant_customers, :restaurant_users
  end

end
