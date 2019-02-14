class Item < ApplicationRecord
	include ItemScope
	
	has_one :picture, as: :imageable
	has_many :item_dimensions, dependent: :destroy
	has_many :store_items, dependent: :destroy
	has_many :dimensions, through: :item_dimensions
	has_many :cart_items, dependent: :destroy	
	belongs_to :category
	has_many :deal_items, dependent: :destroy
	has_many :deals, through: :deal_items

	def out_of_stock(store)
		store_items.find_by(store_id: store.id).out_of_stock
	end

end
