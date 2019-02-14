
attributes :image_content_type
	node(:thumb) { |picture| picture.image.url(:thumb) }
	node(:small) { |picture| picture.image.url(:small) }
	node(:medium) { |picture| picture.image.url(:medium) }
	node(:large) { |picture| picture.image.url(:large) }
	node(:original) { |picture| picture.image.url(:original) }