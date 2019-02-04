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
	p	Category.create!([{id: 1, name: 'Vegan Pizza'},{id: 2, name: 'Meat Pizza'}])
	
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

				{id: 1, name: "Paneer Soya Supreme",category_id: 1},
				{id: 2, name: "Farmers Pick",category_id: 1},
				{id: 3, name: "Tandoori Paneer",category_id: 1},
				{id: 4, name: "Veggie Lover",category_id: 1},
				{id: 5, name: "Veggie Italiano",category_id: 1},
				{id: 6, name: "Veggie Supreme",category_id: 1},
				{id: 7, name: "Country Feast",category_id: 1},
				{id: 8, name: "Chicken Exotica",category_id: 2},
				{id: 9, name: "Chicken Italiano",category_id: 2},
				{id: 10, name: "Chicken Supreme",category_id: 2},
				{id: 11, name: "Triple Chicken Feast",category_id: 2},
				{id: 12, name: "Chicken Tikka",category_id: 2}

			])

	ItemDimension.delete_all
		p	ItemDimension.create!([	
				{id: 1,item_id: 1,dimension_id: 1, price: 5.82}, 	{id: 2,item_id: 1,dimension_id: 2, price: 3.47}, 
				{id: 3,item_id: 2,dimension_id: 1, price: 5.50}, 	{id: 4,item_id: 2,dimension_id: 2, price: 2.83},
				{id: 5,item_id: 3,dimension_id: 1, price: 5.50}, 	{id: 6,item_id: 3,dimension_id: 2, price: 2.83}, 
				{id: 7,item_id: 4,dimension_id: 1, price: 5.50 }, 	{id: 8,item_id: 4,dimension_id: 2, price: 2.83},
				{id: 9,item_id: 5,dimension_id: 1, price: 5.82}, 	{id: 10,item_id: 5,dimension_id: 2, price: 3.47},
				{id: 11,item_id: 6,dimension_id: 1, price: 5.82}, 	{id: 12,item_id: 6,dimension_id: 2, price: 3.47},
				{id: 13,item_id: 7,dimension_id: 1, price: 5.82}, 	{id: 14,item_id: 7,dimension_id: 2, price: 3.47},
				{id: 15,item_id: 8,dimension_id: 1, price: 6.68}, 	{id: 16,item_id: 8,dimension_id: 2, price: 3.79},
				{id: 17,item_id: 9,dimension_id: 1, price: 6.68}, 	{id: 18,item_id: 9,dimension_id: 2, price: 3.79},
				{id: 19,item_id: 10,dimension_id: 1, price: 6.68}, {id: 20,item_id: 10,dimension_id: 2, price: 3.79},
				{id: 21,item_id: 11,dimension_id: 1, price: 5.82}, {id: 22,item_id: 11,dimension_id: 2, price: 3.47}
			])
	OrderStatus.delete_all
			OrderStatus.create!([ { id: 1, status: "PLACED" },{ id: 2, status: "PREPARED" },
				{ id: 3, status: "ONTHEWAY" },{ id: 4, status: "ARRIVED" },		
				{ id: 5, status: "FINISHED" }	
			])
rescue Exception => e
	p raise e.message
end



