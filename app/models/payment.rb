class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :card, optional: true

  def find_paypal_payment
  	payment = PayPal::SDK::REST::Payment.find(transaction_id)
  end

end
