class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :Restaurant_id
      t.integer :template_id
      t.integer :discounted_price
      t.integer :original_price
      t.datetime :start_on
      t.datetime :end_on
      t.boolean :active
      t.text :fineprint
      t.string :product
      t.string :img
      t.integer :quantity
      t.datetime :delivery_time

      t.timestamps
    end
  end
end
