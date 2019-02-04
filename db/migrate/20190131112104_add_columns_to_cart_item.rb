class AddColumnsToCartItem < ActiveRecord::Migration[5.2]

  def change
    add_column :cart_items, :less_ingredient_ids, :text
    add_column :cart_items, :topping_ids, :text
  end

end
