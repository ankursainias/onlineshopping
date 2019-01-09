class CreateDeliveryAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_addresses do |t|
      t.references :user, foreign_key: true
      t.string :session_id
      t.string :line1
      t.string :line2
      t.string :house_no
      t.string :city
      t.integer :postal_code
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6
      t.string :other
      t.boolean :is_default, default: true

      t.timestamps
    end
  end
end
