class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :card, optional: true
end
