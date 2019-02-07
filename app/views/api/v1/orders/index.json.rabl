
if @orders.blank?
	# object false
 #    node :message do
 #      "No delivery in this area"
 #    end
	node(:orders) { [] }
else
	object false
	child @orders, root: "orders", :object_root => false do
	  attributes :id, :sub_total,:grand_total,:discount_total
	end
end
