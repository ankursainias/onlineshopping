class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item
  belongs_to :user, optional: true
  belongs_to :item_dimension

  def sub_total
  	return item_dimension.price * quantity
  end
end
