class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order_status
  belongs_to :cart
  has_many :coupon_redemptions
  has_one :payment

  def pay_now(card)
	  	source = create_source(card)
		  	response = Stripe::Charge.create(
				  :amount => grand_total.to_i * 100,
				  :currency => "inr",
				  :source => "#{source.id}",
				  :capture => false,
				  :description => "Charge for #{ try(:user).present? ? user.email : cart.session_id }"
				)
				charge = {}
	  		charge[:transaction_id] = response.id
	  		charge[:failure_message] = response.failure_message
	  		charge[:failure_code] = response.failure_code
	  		charge[:gateway_status] = response.status
	  		charge[:pay_type] = "Card"
	  		charge[:pay_time] = Time.at(response.created).to_datetime
  	charge
  end

  def create_source(card)
  	source = Stripe::Token.create(
		  :card => {
		    :name => card[:name],
		    :number => card[:number],
		    :exp_month => card[:exp_month],
		    :exp_year => card[:exp_year],
		    :cvc => card[:cvc]
		  },
		)
  	source
  end

end
