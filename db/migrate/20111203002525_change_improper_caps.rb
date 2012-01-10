class ChangeImproperCaps < ActiveRecord::Migration

  def change
    rename_column :restaurant_customers, :Restaurant_id, :restaurant_id
    rename_column :restaurant_customers, :Customer_id, :customer_id
    rename_column :deals, :Restaurant_id, :restaurant_id
  end

end
