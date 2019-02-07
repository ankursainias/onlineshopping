
if @order.blank?
	# object false
 #    node :message do
 #      "No delivery in this area"
 #    end
	node(:order) { [] }
else
	object false
	child @order, root: "order", :object_root => false do
	  attributes :id, :sub_total,:grand_total,:discount_total
	end
end
