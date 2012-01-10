class AddTwitterVariablesToRestaurant < ActiveRecord::Migration
  def change
  
    add_column :restaurants, :twitter_handle, :string
    add_column :restaurants, :twitter_token, :string
    add_column :restaurants, :twitter_secret, :string
  
  end
end
