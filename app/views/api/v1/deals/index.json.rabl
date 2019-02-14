object false
	child @deals, root: "deals", :object_root => false do
		attributes :id, :name,:amount,:initial_time,:end_time,:description
		child :price, root: "price", :object_root => false do
			attributes :id, :title,:p_type
		end
		child :picture, root: "picture", :object_root => false do
			extends 'api/v1/home/picture'
		end
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
	end