class CreateStoreItems < ActiveRecord::Migration[5.2]
  def change
    create_table :store_items do |t|
      t.references :store, foreign_key: true
      t.references :item, foreign_key: true
      t.boolean :out_of_stock, default: false

      t.timestamps
    end
  end
end
