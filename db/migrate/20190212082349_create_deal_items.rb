class CreateDealItems < ActiveRecord::Migration[5.2]
  def change
    create_table :deal_items do |t|
      t.references :deal, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
