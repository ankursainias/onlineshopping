class CreateItemDimensions < ActiveRecord::Migration[5.2]
  def change
    create_table :item_dimensions do |t|
      t.references :item, foreign_key: true
      t.references :dimension, foreign_key: true
      t.float :price, default: 0

      t.timestamps
    end
  end
end
