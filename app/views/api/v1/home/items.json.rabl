object false
	child @categories, root: "categories", :object_root => false do
		attributes :id, :name
		child :items, root: "items", :object_root => false do
		  attributes :id, :name
		  	node(:out_of_stock) { |item| item.out_of_stock(@store) } if @store.present?
		  child :picture, root: "picture", :object_root => false do
		  	extends 'api/v1/home/picture'
		  end
			  child :item_dimensions, root: "item_dimensions", :object_root => false do
			  	attributes :id,:price
				  	child :dimension,root: "dimension", :object_root => false do
				  		attributes :id,:size,:serve
				  	end
			  end
		end
			child :ingredients, root: "ingredients", :object_root => false do
			 	attributes :id, :name
			end	
	end
	
	child @toppings, root: "toppings", :object_root => false do
	  attributes :id, :name,:price
	end
