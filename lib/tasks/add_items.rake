task :add_items => :environment do
	puts "Start loading..."
	salad = Category.find_by(name: "Salad")
	drink = Category.find_by(name: "Drink")
	dessert = Category.find_by(name: "Dessert")
	side = Category.find_by(name: "Side")
	stores = Store.all
	puts "adding salad items"
	# p Item.where(id: [14,15,16]).destroy_all
	 p items = salad.items.create([{id: 14,name: "FRESH SPINACH AND OLIVES SALAD"},
							   {id: 15, name: "WILD ROCKET SALAD"},	
							   {id: 16, name: "CAPRESE DI BUFALA"}
							  ])
	prices = [4.95,3.95,5.45]
		puts "Initialize  salad item price"
	prices.each_with_index do |price,index|
		items[index].item_dimensions.create(dimension_id: 2, price: price)
	end
		puts "adding salad item into stores"
		stores.each do |store|
			items.each_with_index do |item, index|
				store.store_items.create!(item_id: item.id)
			end
		end
	puts "adding drink items"
	# p Item.where(id: [17,18,19,20,21,22,23,24,25]).destroy_all
	items = drink.items.create([{id: 17,name: "PROSECCO"},
													   {id: 18,name: "GAVI DI GAVI"},	
													   {id: 19,name: "PINOT GRIGIO"},	
													   {id: 20,name: "VALPOLICELLA RIPASSO"},
													   {id: 21,name: "MONTEPULCIANO D'ABRUZZO 2012"},
													   {id: 22,name: "PERONI NASTRO AZZURO GLUTEN FREE"},
													   {id: 23,name: "SAN BENEDETTO STILL WATER"},
													   {id: 25,name: "OLD MOUT CIDER KIWI & LIME"}
													  ])
	puts "Initialize  drink item price"
	prices = [14.95,14.95,9.95,16.95,9.95,3.75,4.75,4.75,4.75]
	prices.each_with_index do |price,index|
		items[index].item_dimensions.create(dimension_id: 2, price: price)
	end
	puts "adding drink item into stores"
		stores.each do |store|
			items.each_with_index do |item, index|
				store.store_items.create!(item_id: item.id)
			end
		end
	puts "adding dessert items"	
	prices = [3.99,3.99,3.99,4.99,4.99,4.99,1.99]
	items = dessert.items.create([{name: "STRAWBERRY CHEESCAKE"},
														   {name: "TIRAMISU"},	
														   {name: "BANOFFEE PIE"},	
														   {name: "JUDE'S CHOCOLATE ICE CREAM"},
														   {name: "JUDE'S SALTED CARAMEL ICE CREAM"},
														   {name: "JUDE'S VERY VANILLA ICE CREAM"},
														   {name: "JUDE'S MINI MANGO SORBET"}
														  ])
		puts "Initialize dessert item price"
	prices.each_with_index do |price,index|
		items[index].item_dimensions.create(dimension_id: 2, price: price)
	end
	puts "adding dessert item into stores"
	stores.each do |store|
		items.each_with_index do |item, index|
			store.store_items.create!(item_id: item.id)
		end
	end
	puts "adding side items"	
	prices = [3.95,4.95,3.95,4.95,5.25,4.95,4.95]
	items = side.items.create([{name: "FOCACCIA POMODORO"},
							   {name: "FOCACCIA DI BUFALA"},	
							   {name: "GARLIC PIZZA BREAD"},	
							   {name: "GARLIC PIZZA BREAD WITH MOZZARELLA"},
							   {name: "SWEET AND SMOKY BARBECUE CHICKEN WINGS"},
							   {name: "ROTOLO DI FORMAGGI"},
							   {name: "CHEESY POTATO WEDGES WITH GORGONZOLA"}
							  ])
	puts "Initialize side item price"
	prices.each_with_index do |price,index|
		items[index].item_dimensions.create(dimension_id: 2, price: price)
	end
	puts "adding side item into stores"
	stores.each do |store|
		items.each_with_index do |item, index|
			store.store_items.create!(item_id: item.id)
		end
	end
	puts "yeh Loading successfully finished"
end