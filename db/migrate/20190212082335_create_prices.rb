class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.string :title
      t.string :p_type
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
