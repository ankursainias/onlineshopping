class Dimension < ApplicationRecord
	has_many :item_dimensions, dependent: :destroy
end
