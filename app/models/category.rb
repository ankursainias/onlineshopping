class Category < ApplicationRecord
	has_many :brand_categories, dependent: :destroy
	has_many :items, dependent: :destroy
end
