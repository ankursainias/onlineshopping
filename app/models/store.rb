class Store < ApplicationRecord
	has_many :open_hours, dependent: :destroy
	has_many :store_items, dependent: :destroy
	has_many :orders, dependent: :destroy
	has_many :items, through: :store_items
	after_create :set_open_hours
	before_save :set_lat_lng
	acts_as_mappable   :default_units => :miles,
	                   :default_formula => :sphere,
	                   :lat_column_name => :lat,
	                   :lng_column_name => :lng

	searchable do
		text :postal_code
		# paginate :page => 1, :per_page => 2
	end

	# latlon(:location) { 
 #      Sunspot::Util::Coordinates.new(store.lat, store.lng)
 #    }

	def store_item(itemId)
		StoreItem.find_by(store_id: id, item_id: itemId)
	end

	def set_open_hours
		days = [0,1,2,3,4,5,6]
		days.each do |day|
			OpenHour.create!(store_id: id,day: day,open: "08:00AM", close: "11:00PM", valid_from: Time.now, valid_through: Time.now + 1.year)
		end
	end

	def set_lat_lng
		return true if self.lat.present? && self.lng.present?
		result = Geokit::Geocoders::GoogleGeocoder.geocode(address)
		self.lat = result.lat
		self.lng = result.lng
	end

	def current_day_open_hours
		oh = open_hours.find_by(day: Date.today.wday)
		"#{oh.english_day} #{oh.formated_open} to #{oh.formated_close}"
	end


end
