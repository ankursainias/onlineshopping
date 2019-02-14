class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :card, optional: true
  validates_presence_of :card_id,message: " id is missing", if: :card_based?
  validates :pay_type, inclusion: { in: %w(Cash Card Paypal)}

    after_initialize do
  		if self.new_record?
  			self.currency ||= DEFAULT_CURRENCY
        self.pay_time ||= Time.current
 	 			self.completed ||= true if card_payment?
 	 		end
	end

  def card_based?
  	pay_type == "Card" && order.user.present?
  end

  def card_payment?
    pay_type == "Card"
  end

  def find_paypal_payment
    PayPal::SDK::REST::Payment.find(transaction_id)
  end

end
