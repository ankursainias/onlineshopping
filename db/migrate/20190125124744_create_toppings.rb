class CreateToppings < ActiveRecord::Migration[5.2]
  def change
    create_table :toppings do |t|
      t.string :name
      t.float :price, default: 0
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
