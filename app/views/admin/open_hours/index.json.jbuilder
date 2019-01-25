json.array!(@open_hours) do |open_hour|
  json.extract! open_hour, :store_id, :day, :open, :close, :valid_from, :valid_through
  json.url open_hour_url(open_hour, format: :json)
end