
if @stores.blank?
	# object false
 #    node :message do
 #      "No delivery in this area"
 #    end
	node(:stores) { [] }
else
	object false
	child @stores, root: "stores", :object_root => false do
	  attributes :id, :name,:address,:postal_code,:city,:phone,:lat,:lng
	
		child :open_hours, root: "open_hours", :object_root => false do
	  		attributes :day,:english_day,:formated_open,:formated_close
			end
	end
end
