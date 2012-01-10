class ChangeCustomersToUsers < ActiveRecord::Migration

  def change
    rename_table :customers, :users
    add_column :users, :admin, :boolean, :default => false
    add_column :users, :restaurant_id, :integer
  end

end
