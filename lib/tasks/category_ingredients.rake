task :category_ingredients => :environment do 
	ingredients = Ingredient.all
	category = Category.find_by(name: "Vegan Pizza")
	ingredients.each_with_index do |ingredient,index|
		ingredient.category_ingredients.create!(category_id: category.id)
	end
end