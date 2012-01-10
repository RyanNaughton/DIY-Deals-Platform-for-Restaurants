class CreateRestaurantCustomers < ActiveRecord::Migration
  def change
    create_table :restaurant_customers do |t|
      t.integer :Restaurant_id
      t.integer :Customer_id
      t.datetime :date_joined

      t.timestamps
    end
  end
end
