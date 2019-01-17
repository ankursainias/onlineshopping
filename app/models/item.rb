class Item < ApplicationRecord
	has_one :picture, as: :imageable
	has_many :item_dimensions, dependent: :destroy
	scope :veg_pizzas, -> { where(veg: true) }
	scope :non_veg_pizzas, -> { where(veg: false) }
	has_many :cart_items	

	def testing_call
		puts "Ankur saini testing this application."
	end
end
