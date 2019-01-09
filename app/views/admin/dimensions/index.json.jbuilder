json.array!(@dimensions) do |dimension|
  json.extract! dimension, :size, :serve
  json.url dimension_url(dimension, format: :json)
end