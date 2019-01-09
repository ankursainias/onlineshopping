json.array!(@item_dimensions) do |item_dimension|
  json.extract! item_dimension, :item_id, :dimension_id, :price
  json.url item_dimension_url(item_dimension, format: :json)
end