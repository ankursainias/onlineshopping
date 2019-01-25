class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :postal_code
      t.string :city
      t.string :phone
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6

      t.timestamps
    end
  end
end
