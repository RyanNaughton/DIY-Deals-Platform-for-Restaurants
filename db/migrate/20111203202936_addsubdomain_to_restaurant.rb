class AddsubdomainToRestaurant < ActiveRecord::Migration

  def change
    add_column :restaurants, :subdomain, :string
  end
end
