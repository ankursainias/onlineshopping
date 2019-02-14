class Card < ApplicationRecord
  belongs_to :user

  def gateway_payment_request(*options)
    response = Stripe::Charge.create(
      :amount => options[0].to_i * 100,
      :currency => DEFAULT_CURRENCY,
      :source => "#{gateway_card_id}",
      :capture => true,
      :description => "Charge for customer"    
      )
    response
  end

end
