task :set_lat_lng => :environment do
	Store.all.each do |store|
		# results = Geocoder.search(store.address)
		result = Geokit::Geocoders::GoogleGeocoder.geocode(store.address)
		store.lat = result.lat
		store.lng = result.lng
		store.save!
	end
end