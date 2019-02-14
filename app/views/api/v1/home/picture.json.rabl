attributes :image_content_type
  	node(:original) { |picture| picture.image.url(:original) }
  	node(:medium) { |picture| picture.image.url(:medium) }
  	node(:thumb) { |picture| picture.image.url(:thumb) }
  	node(:large) { |picture| picture.image.url(:large) }