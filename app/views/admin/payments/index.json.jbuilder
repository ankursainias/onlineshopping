json.array!(@payments) do |payment|
  json.extract! payment, :order_id, :transaction_id, :pay_time, :card_id, :failure_message, :failure_code, :gateway_status, :captrued, :pay_type
  json.url payment_url(payment, format: :json)
end