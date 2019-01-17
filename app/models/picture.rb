class Picture < ApplicationRecord
	belongs_to :imageable, polymorphic: true
	include Paperclip::Glue
	has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/pizza1.png"
    validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg image/png) 
end
