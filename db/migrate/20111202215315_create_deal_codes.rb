class CreateDealCodes < ActiveRecord::Migration
  def change
    create_table :deal_codes do |t|
      t.string :code
      t.integer :transaction_id
      t.integer :deal_id

      t.timestamps
    end
  end
end
