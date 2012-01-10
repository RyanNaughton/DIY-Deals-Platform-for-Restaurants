class AddVariablesToTables < ActiveRecord::Migration
  def change
  
  add_column :customers, :email_confirmed, :boolean, :default => false
  add_column :customers, :phone_confirmed, :boolean, :default => false
  add_column :customers, :email_confirmation_code, :string
  add_column :customers, :sms_confirmation_code, :string
  
  end
end
