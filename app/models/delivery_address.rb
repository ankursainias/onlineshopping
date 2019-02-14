class DeliveryAddress < ApplicationRecord
  belongs_to :user, optional: true
  has_many :orders, dependent: :destroy
  acts_as_mappable

    after_initialize do
  		unless self.lat.present? && self.lng.present?		
				result = Geokit::Geocoders::GoogleGeocoder.geocode(full_street_address)
				self.lat = result.lat
				self.lng = result.lng
 	 		end
	end

	def full_street_address
			[house_no,line1,line2, city, state, postal_code,other].reject(&:blank?).join(",")
	end

end
