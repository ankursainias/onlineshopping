class Ingredient < ApplicationRecord
	scope :actives, -> {where(active: true)}
	has_many :category_ingredients, dependent: :destroy
	validates_uniqueness_of :name
end
