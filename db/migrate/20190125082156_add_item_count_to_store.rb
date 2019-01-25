class AddItemCountToStore < ActiveRecord::Migration[5.2]
  def change
    add_column :stores, :store_items_count, :integer, default: 0
    	# Store.connection.execute << -SQL
    	# UPDATE stores
    	# SET store_item_count = 
    	# (SELECT COUNT(*)
    	#  FROM store_items 
    	#  WHERE store_id = store_items.id)
    	# SQL
  end
end
