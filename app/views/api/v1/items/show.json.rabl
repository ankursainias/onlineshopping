object false
	child @item.category,root: "category", :object_root => false do
		 	attributes :id, :name
			 	child @item, root: "item", :object_root => false do
				 attributes :id, :name
				 node(:out_of_stock) { @item.out_of_stock(@store) } if @store.present?
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