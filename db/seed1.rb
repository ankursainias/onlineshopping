Brand.destroy_all
		Brand.create
			({[
				id: 1, name: "Puma",
				id: 2, name: "Nike",
				id: 3, name: "Reebok",
				id: 4, name: "Asics",
				id: 5, name: "Woodland",
				id: 6, name: "Redchief"
				id: 7, name: "Fastrack"
				id: 8, name: "Pizza Hut"
				id: 9, name: "Domino's Pizza"
			]})
			
Category.destroy_all
		Category.create
			({[
				id: 1, name: 'Clothes',
				id: 2, name: 'Furniture',
				id: 3, name: 'Groceries',
				id: 4, name: 'Electronics'
				id: 5, name: 'Shoes',
				id: 6, name: 'Wrist Watch'
				id: 7, name: 'Pizza'
			]})
BrandCategory.destroy_all
	BrandCategory.create
			({[
				id: 1, brand_id: 1, category_id: 1,
				id: 2, brand_id: 1, category_id: 5,
				id: 3, brand_id: 2, category_id: 1,
				id: 4, brand_id: 2, category_id: 5,
				id: 5, brand_id: 3, category_id: 1,
				id: 6, brand_id: 3, category_id: 5,
				id: 7, brand_id: 3, category_id: 1,
				id: 8, brand_id: 3, category_id: 5,
				id: 9, brand_id: 4, category_id: 5,
				id: 10, brand_id: 5, category_id: 1,
				id: 11, brand_id: 5, category_id: 5,
				id: 12, brand_id: 6, category_id: 5,
				id: 13, brand_id: 7, category_id: 6,
				id: 14, brand_id: 8, category_id: 7,
				id: 15, brand_id: 9, category_id: 7
			]})

Dimension.destroy_all
	Dimension.create
			({[
				id: 1, size: 'Personal', serve: 1
				id: 2, size: 'Medium', serve: 2
				id: 3, size: 'S', serve: 1,
				id: 4, size: 'M', serve: 1,
				id: 5, size: 'L', serve: 1,
				id: 6, size: 'XL', serve: 1,
				id: 7, size: 'XXL', serve: 1
			]})


	Item.destroy_all
			Item.create
			({[
				id: 1, name: "Paneer Soya Supreme", kind: ,
				id: 2, name: "Chicken Exotica", kind: 
			]})