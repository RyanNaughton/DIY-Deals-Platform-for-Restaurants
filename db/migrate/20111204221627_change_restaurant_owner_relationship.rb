class ChangeRestaurantOwnerRelationship < ActiveRecord::Migration

  add_column :restaurants, :user_id, :integer
  remove_column :users, :restaurant_id
  remove_column :users, :admin

end
