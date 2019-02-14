class CreateDeals < ActiveRecord::Migration[5.2]
  def change
    create_table :deals do |t|
      t.references :price, foreign_key: true
      t.string :name
      t.float :amount, default: 0
      t.string :image
      t.datetime :initial_time
      t.datetime :end_time
      t.string :description

      t.timestamps
    end
  end
end
