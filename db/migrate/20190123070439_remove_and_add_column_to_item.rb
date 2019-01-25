class RemoveAndAddColumnToItem < ActiveRecord::Migration[5.2]
  def change
  	remove_column :items, :veg, :boolean
  	add_reference :items, :category
  end
end
