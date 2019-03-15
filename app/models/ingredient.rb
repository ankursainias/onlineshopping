class Ingredient < ApplicationRecord
	scope :actives, -> {where(active: true)}
	has_many :category_ingredients, dependent: :destroy
end
