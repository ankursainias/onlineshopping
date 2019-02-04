class Order < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :order_status
  belongs_to :cart
  belongs_to :store
  belongs_to :delivery_address
  has_many :coupon_redemptions
  has_many :payments
  attr_accessor :line1,:line2,:house_no,:postal_code,:lat,:lng,
  							:state,:city,:other,:session_id,:delivery_address_id
  
  after_initialize do
  		if self.new_record?
  			deliveryAddress = set_delivery_address
  			self.delivery_address ||= deliveryAddress
 	 			self.order_status ||= order_status_with("PLACED")
 	 		end
	end

  def set_delivery_address
			deliveryAddress = DeliveryAddress.find_by(id: delivery_address_id)
			deliveryAddress = DeliveryAddress.create!(address_params)  if deliveryAddress.nil?
  		deliveryAddress
  end

  def order_status_with(status)
  		OrderStatus.find_by(status: status)
  end

  def cash_payment
  		payments.new(pay_type: "Cash").save!
  end

  def card_payment(options,grand_total)
    if options[:card_id].present?
      @card = Card.find(card_id)
      response = @card.gateway_payment(grand_total)
    end
  end

  def paypal_payment(options)

  end

  def pay_now(card)
	  	source = create_source(card)
		  	response = Stripe::Charge.create(
				  :amount => grand_total.to_i * 100,
				  :currency => "gbp",
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

  private

  def address_params
	   params = {}
     params[:line1] = self.line1
     params[:line2] = self.line2
     params[:state] = self.state
     params[:city] = self.city
     params[:house_no] = self.house_no
     params[:lat] = self.lat
     params[:lng] = self.lng
     params[:other] = self.other
     params[:postal_code] = self.postal_code
     params[:session_id] = self.session_id
     params[:user_id] = self.user.id if self.user.present?
     params
  end

end
