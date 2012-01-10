class CreateDealTemplates < ActiveRecord::Migration
  def change
    create_table :deal_templates do |t|
      t.string :text1
      t.string :text2
      t.string :text3
      t.string :text4
      t.string :text5

      t.timestamps
    end
  end
end
