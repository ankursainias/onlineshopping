json.array!(@deal_items) do |deal_item|
  json.extract! deal_item, :deal_id, :item_id
  json.url deal_item_url(deal_item, format: :json)
end