class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  DEFAULT_CURRENCY = "GBP"
end
