class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :deal_id
      t.integer :customer_id

      t.timestamps
    end
  end
end
