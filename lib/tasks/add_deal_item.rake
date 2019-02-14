task :add_deal_item => :environment do
	Deal.active.each do |deal|
		deal.deal_items.create(item_id: Item.all.sample.id)
		deal.deal_items.create(item_id: Item.all.sample.id)
	end
end