class Price < ApplicationRecord
	has_many :deals, dependent: :destroy
	validates :c_type, inclusion: { in: %w(percentage amount )}
end
