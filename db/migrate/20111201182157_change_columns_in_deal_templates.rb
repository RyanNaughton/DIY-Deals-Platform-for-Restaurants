class ChangeColumnsInDealTemplates < ActiveRecord::Migration
  
  def change
    remove_column :deal_templates, :text2
    remove_column :deal_templates, :text3
    remove_column :deal_templates, :text4
    remove_column :deal_templates, :text5
    rename_column :deal_templates, :text1, :description
  end
  
end
