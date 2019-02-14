class DeliveryAddress < ApplicationRecord
  belongs_to :user, optional: true
  has_many :orders, dependent: :destroy
  acts_as_mappable
end
