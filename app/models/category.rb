class Category < ApplicationRecord
	has_many :brand_categories, dependent: :destroy
	has_many :items, dependent: :destroy
	has_many :category_ingredients, dependent: :destroy
	has_many :ingredients, through: :category_ingredients
 	has_many :childs, class_name: "Category", foreign_key: "parent_id"	
  belongs_to :parent, class_name: "Category"
end
