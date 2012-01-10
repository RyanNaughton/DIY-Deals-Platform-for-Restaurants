class ChangeTemplateId < ActiveRecord::Migration

  def change
    rename_column :deals, :template_id, :deal_template_id
  end

end
