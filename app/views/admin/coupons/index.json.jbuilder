json.array!(@coupons) do |coupon|
  json.extract! coupon, :code, :description, :valid_from, :valid_until, :redemption_limit, :coupon_redemptions_count, :amount, :c_type
  json.url coupon_url(coupon, format: :json)
end