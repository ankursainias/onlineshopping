class DeliveryAddress < ApplicationRecord
  belongs_to :user, optional: true
  acts_as_mappable
end
