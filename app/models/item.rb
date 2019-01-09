class Item < ApplicationRecord
	has_one :picture, as: :imageable
	has_many :item_dimensions, dependent: :destroy
	scope :veg_pizzas, -> { where(veg: true) }
	scope :non_veg_pizzas, -> { where(veg: false) }
end
