class CreateDimensions < ActiveRecord::Migration[5.2]
  def change
    create_table :dimensions do |t|
      t.string :size, default: "Personal"
      t.integer :serve, default: 1

      t.timestamps
    end
  end
end
