task :store_items => :environment do
	puts "Start creating..."
	StoreItem.destroy_all
	Store.all.each_with_index do |store,index|
		Item.all.each_with_index do |item, index|
			store.store_items.create!(item_id: item.id)
		end
	end
	puts "Successfully created"
end