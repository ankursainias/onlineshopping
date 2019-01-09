class AddItemDimensionToCartItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :cart_items, :item_dimension, foreign_key: true
  end
end
