task :add_category => :environment do
	Category.create!([{id: 2, name: "Meat Pizza"},
						{id: 3, name: "Side"},
						{id: 4, name: "Salad"},
						{id: 5, name: "Drink"},
						{id: 6, name: "Dessert"}])
	Category.first.update name: "Vegan Pizzas" 
	
end