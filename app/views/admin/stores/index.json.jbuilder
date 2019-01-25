json.array!(@stores) do |store|
  json.extract! store, :name, :address, :postal_code, :city, :phone
  json.url store_url(store, format: :json)
end