class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :phone
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :password_digest

      t.timestamps
    end
  end
end
