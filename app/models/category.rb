class Category < ApplicationRecord
	has_many :brand_categories, dependent: :destroy
	has_many :items, dependent: :destroy
	has_many :category_ingredients, dependent: :destroy
	has_many :ingredients, -> {where(active: true)}, through: :category_ingredients
	validates_uniqueness_of :name
end
