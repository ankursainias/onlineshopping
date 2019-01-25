class Item < ApplicationRecord
	has_one :picture, as: :imageable
	has_many :item_dimensions, dependent: :destroy
	has_many :store_items, dependent: :destroy
	has_many :dimensions, through: :item_dimensions
	scope :veg_pizzas, -> { where(category_id: category_with("Vegan Pizzas")) }
	scope :non_veg_pizzas, -> { where(category_id: category_with("Meat Pizza")) }
	scope :salads, -> { where(category_id: category_with("Salad")) }
	scope :drinks, -> { where(category_id: category_with("Drink")) }
	scope :desserts, -> { where(category_id: category_with("Dessert")) }
	scope :sides, -> { where(category_id: category_with("Side")) }
	has_many :cart_items	
	belongs_to :category

	def out_of_stock(store)
		store_items.find_by(store_id: store.id).out_of_stock
	end

	def self.category_with(name)
		Category.find_by(name: name)
	end

end
