class AddHtmlDescriptionToDealTemplate < ActiveRecord::Migration
  def change
  
    add_column :deal_templates, :html_description, :string
    rename_column :deal_templates, :description, :text_description
  
  end
end
