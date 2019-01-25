object false
	child @categories, root: "categories", :object_root => false do
		attributes :id, :name
		child :items, root: "items", :object_root => false do
		  attributes :id, :name
		  	node(:out_of_stock) { |item| item.out_of_stock(@store) } if @store.present?
		  child :picture, root: "picture", :object_root => false do
		  	attributes :image_content_type
			  	node(:original) { |picture| picture.image.url(:original) }
			  	node(:medium) { |picture| picture.image.url(:medium) }
			  	node(:thumb) { |picture| picture.image.url(:thumb) }
		  end
			  child :item_dimensions, root: "item_dimensions", :object_root => false do
			  	attributes :id,:price
				  	child :dimension,root: "dimension", :object_root => false do
				  		attributes :id,:size,:serve
				  	end
			  end
		end
		child @ingredients, root: "ingredients", :object_root => false do
		 	attributes :id, :name
		end		
	end
