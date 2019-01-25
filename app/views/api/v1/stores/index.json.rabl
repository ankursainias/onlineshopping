
if @stores.blank?
	# object false
 #    node :message do
 #      "No delivery in this area"
 #    end
	node(:stores) { [] }
else
	object false
	child @stores, root: "stores", :object_root => false do
	  attributes :id, :name,:address,:postal_code,:city,:phone,:lat,:lng,:current_day_open_hours
	end
	node(:current_locate_postal_code) { @postal_code }
end
