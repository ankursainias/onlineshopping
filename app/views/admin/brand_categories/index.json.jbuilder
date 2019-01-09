json.array!(@brand_categories) do |brand_category|
  json.extract! brand_category, :brand_id, :category_id
  json.url brand_category_url(brand_category, format: :json)
end