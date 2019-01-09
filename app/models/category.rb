class Category < ApplicationRecord
	has_many :brand_categories, dependent: :destroy
end
