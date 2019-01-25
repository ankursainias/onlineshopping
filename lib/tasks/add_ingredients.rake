task :add_ingredients => :environment do
	begin
	puts "Adding Ingredients..."
	Ingredient.create!([{id: 1, name: "Fresh Basil"},
						{id: 2, name: "Mozzarella"},
						{id: 3, name: "Pancetta"},
						{id: 4, name: "Pulled Pork"},
						{id: 5, name: "Red Onion"},
						{id: 6, name: "Smoked BBQ Sauce"},
						{id: 7, name: "Sweet Peppers"},
						{id: 8, name: "Tomato Sauce"},
						{id: 9, name: "Wild Rocket"}
						])
	puts "Ingredient successfully added."
	puts "Adding Toppings ..."

	Topping.create!([{id: 1, name: "Anchovies",price: 1.50 },
					 {id: 2, name: "Artichoke Hearts",price: 1.50 },
					 {id: 3, name: "Buffalo D.O.P. Mozzarella",price: 2.0},
					 {id: 4, name: "Buffalo Salami",price: 2.0},
					 {id: 5, name: "Cajun-Spiced Chicken",price: 2.0},
					 {id: 6, name: "Cream (White Base)",price: 1.0},
					 {id: 7, name: "Fresh Basil",price: 1.0},
					 {id: 8, name: "Fresh Field Mushrooms",price: 1.5},
					 {id: 9, name: "Fresh Red Chilli",price: 1.0},
					 {id: 10, name: "Fresh Rosemary",price: 1.0},
					 {id: 11, name: "Fresh baby spinach",price: 1.5},
					 {id: 12, name: "Friarelli (Italian Wild Broccoli)",price: 1.5},
					 {id: 13, name: "Garlic Butter",price: 1.0},
					 {id: 14, name: "Gorgonzola Dolce",price: 2.0},
					 {id: 15, name: "Gourmet Black Olives",price: 1.5},
					 {id: 16, name: "Grated Vegetarian Cheese",price: 1.5},
					 {id: 17, name: "Mixed Vegetables",price: 1.5},
					 {id: 18, name: "Mozzarella",price: 1.5},
					 {id: 19, name: "Nduja Salami",price: 1.5},
					 {id: 20, name: "Olive Oil",price: 0.0},
					 {id: 21, name: "Oregano",price: 0.0},
					 {id: 22, name: "Oven-Roasted Tomatoes",price: 1.5},
					 {id: 23, name: "Pancetta",price: 2.0},
					 {id: 24, name: "Pesto",price: 1.0},
					 {id: 25, name: "Pineapple",price: 1.5}
					])
		rescue Exception => e
			puts e.message
			raise e.message
	end

end 