json.array!(@toppings) do |topping|
  json.extract! topping, :name, :price, :active
  json.url topping_url(topping, format: :json)
end