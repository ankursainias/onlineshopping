class Brand < ApplicationRecord
	has_many :pictures, as: :imageable
	has_many :brand_categories, dependent: :destroy
end
