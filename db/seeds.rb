# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

begin
Brand.delete_all
	p	Brand.create!([{id: 1, name: "Pizza Hut" },{id: 2, name: "Domino's Pizza"}])
			
Category.delete_all
	p	Category.create!([{id: 1, name: 'Pizza'}])
	
BrandCategory.delete_all
	p	BrandCategory.create!([
			{id: 1, brand_id: 1, category_id: 1}, {id: 2, brand_id: 2, category_id: 1}
		])

Dimension.delete_all
	p Dimension.create!([
				{id: 1, size: 'Personal', serve: 1}, {id: 2, size: 'Medium', serve: 2}
			])


	Item.delete_all
		p	Item.create!([

				{id: 1, name: "Paneer Soya Supreme", veg: true},
				{id: 2, name: "Farmers Pick", veg: true},
				{id: 3, name: "Tandoori Paneer", veg: true},
				{id: 4, name: "Veggie Lover", veg: true},
				{id: 5, name: "Veggie Italiano", veg: true},
				{id: 6, name: "Veggie Supreme", veg: true},
				{id: 7, name: "Country Feast", veg: true},
				{id: 8, name: "Chicken Exotica", veg: false},
				{id: 9, name: "Chicken Italiano", veg: false},
				{id: 10, name: "Chicken Supreme", veg: false},
				{id: 11, name: "Triple Chicken Feast", veg: false},
				{id: 12, name: "Chicken Tikka", veg: false}

			])

	ItemDimension.delete_all
		p	ItemDimension.create!([	
				{id: 1,item_id: 1,dimension_id: 1, price: 545}, 	{id: 2,item_id: 1,dimension_id: 2, price: 325}, 
				{id: 3,item_id: 2,dimension_id: 1, price: 515}, 	{id: 4,item_id: 2,dimension_id: 2, price: 265},
				{id: 5,item_id: 3,dimension_id: 1, price: 515}, 	{id: 6,item_id: 3,dimension_id: 2, price: 265}, 
				{id: 7,item_id: 4,dimension_id: 1, price: 515 }, 	{id: 8,item_id: 4,dimension_id: 2, price: 265},
				{id: 9,item_id: 5,dimension_id: 1, price: 545}, 	{id: 10,item_id: 5,dimension_id: 2, price: 325},
				{id: 11,item_id: 6,dimension_id: 1, price: 545}, 	{id: 12,item_id: 6,dimension_id: 2, price: 325},
				{id: 13,item_id: 7,dimension_id: 1, price: 545}, 	{id: 14,item_id: 7,dimension_id: 2, price: 325},
				{id: 15,item_id: 8,dimension_id: 1, price: 625}, 	{id: 16,item_id: 8,dimension_id: 2, price: 355},
				{id: 17,item_id: 9,dimension_id: 1, price: 625}, 	{id: 18,item_id: 9,dimension_id: 2, price: 355},
				{id: 19,item_id: 10,dimension_id: 1, price: 625}, {id: 20,item_id: 10,dimension_id: 2, price: 355},
				{id: 21,item_id: 11,dimension_id: 1, price: 545}, {id: 22,item_id: 11,dimension_id: 2, price: 325}
			])
	OrderStatus.delete_all
			OrderStatus.create!([ { id: 1, status: "PLACED" },{ id: 2, status: "PREPARED" },
				{ id: 3, status: "ONTHEWAY" },{ id: 4, status: "ARRIVED" },		
				{ id: 5, status: "FINISHED" }	
			])
rescue Exception => e
	p raise e.message
end



