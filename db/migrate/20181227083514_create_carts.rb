class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.string :session_id, default: ""
      t.references :user, foreign_key: true
      t.boolean :purchased, default: false

      t.timestamps
    end
  end
end
