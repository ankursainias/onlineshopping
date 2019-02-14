object false
	child @deals, root: "deals", :object_root => false do
	  attributes :id, :name,:amount,:description
	  	child :price, root: "price", :object_root => false do
	  		attributes :id, :title,:p_type
		end
		child :picture, root: "picture", :object_root => false do
	  		extends '/api/v1/home/picture'
		end
	end