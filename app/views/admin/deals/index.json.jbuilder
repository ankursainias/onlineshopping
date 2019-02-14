json.array!(@deals) do |deal|
  json.extract! deal, :price_id, :name, :image, :initial_time, :end_time, :description, :amount
  json.url deal_url(deal, format: :json)
end