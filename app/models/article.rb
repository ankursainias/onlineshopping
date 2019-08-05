class Article < ApplicationRecord
	has_rich_text :content
	validates :new, presence: true

end
