class ItemDimension < ApplicationRecord
  belongs_to :item
  belongs_to :dimension
  has_many :cart_items
end
