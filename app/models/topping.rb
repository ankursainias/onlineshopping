class Topping < ApplicationRecord
	scope :actives, -> {where(active: true)}
end
