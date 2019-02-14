class Price < ApplicationRecord
	has_many :deals, dependent: :destroy
end