class Ingredient < ApplicationRecord
	scope :actives, -> {where(active: true)}
end
