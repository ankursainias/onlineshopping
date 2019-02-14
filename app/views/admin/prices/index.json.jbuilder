json.array!(@prices) do |price|
  json.extract! price, :title, :p_type, :active
  json.url price_url(price, format: :json)
end