task :open_hours => :environment do
	days = [1,2,3,4,5,6,7]
	Store.where.not(id: 1).each do |store|
	days.each do |day|	
		store.open_hours.create!(day: day, open: "09:00AM", close: "12:00PM",valid_from: Time.now,valid_through: Time.now + 1.year)
		end
	end
end