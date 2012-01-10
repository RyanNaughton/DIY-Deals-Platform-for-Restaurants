class AddSmsNumToRestaurant < ActiveRecord::Migration
  def change
  add_column :restaurants, :smsNum, :string
  end
  
end
