module ItemScope
	extend ActiveSupport::Concern

		included do
				scope :veg_pizzas, -> { where(category_id: category_with("Vegan Pizza")) }
				scope :non_veg_pizzas, -> { where(category_id: category_with("Meat Pizza")) }
				scope :salads, -> { where(category_id: category_with("Salad")) }
				scope :drinks, -> { where(category_id: category_with("Drink")) }
				scope :desserts, -> { where(category_id: category_with("Dessert")) }
				scope :sides, -> { where(category_id: category_with("Side")) }
		end

	 module ClassMethods

		def category_with(name)
			Category.find_by(name: name)
		end
		
	 end

end