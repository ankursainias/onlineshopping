json.array!(@ingredients) do |ingredient|
  json.extract! ingredient, :name, :active
  json.url ingredient_url(ingredient, format: :json)
end