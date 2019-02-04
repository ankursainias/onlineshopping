class Card < ApplicationRecord
  belongs_to :user


  def gateway_payment(grand_total)
    response = Stripe::Charge.create(
      :amount => grand_total.to_i * 100,
      :currency => DEFAULT_CURRENCY,
      :source => "#{gateway_card_id}",
      :capture => false,
      :description => "Charge for #{ try(:user).present? ? user.email : "As a Firezza Guest User" }"
    )
    response
  end

end
