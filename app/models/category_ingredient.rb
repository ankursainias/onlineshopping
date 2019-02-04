class CategoryIngredient < ApplicationRecord
  belongs_to :category
  belongs_to :ingredient
end
