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

  def card_payment(options)
    begin
      if options[:user_type] == "Guest"
      p  token = create_source(options[:card])
        response = gateway_payment_request(options[:grand_total],token.try(:id))
      else
        @card = Card.find_by(id: options[:id])
        if @card.present?
          response = @card.gateway_payment_request(options[:grand_total])
        else
          token = create_source(options[:card])
          scard = gateway_add_card_request(token)
          if scard[1] == "new"
            @card = user.cards.new(gateway_card_id: token.card.id)
            @card.exp_month = token.card.exp_month
            @card.exp_year = token.card.exp_year
            @card.last4 = token.card.last4
            @card.card_type = token.card.brand
            @card.name = token.card.name
            @card.fingerprint = token.card.fingerprint
            @card.save!
            user.cards.where.not(id: @card.id).update_all(default: false)
          else
            @card = scard[0]
          end
          response = @card.gateway_payment_request(options[:grand_total])
        end
      end
      create_payment(response)

    rescue Stripe::StripeError => e
    rescue Exception => e
     raise e.message
    end

  end

  def create_payment(response)
      payment = payments.new(pay_type: "Card")
      payment.transaction_id = response.id
      payment.pay_time = Time.at(response.created).to_datetime
      payment.failure_message = response.failure_message
      payment.failure_code = response.failure_code
      payment.gateway_status = response.status
      payment.captrued = response.captured
      payment.save!
  end

  def gateway_add_card_request(source)
    begin
      card = user.cards.find_by(fingerprint: source.card.fingerprint)
      customer = find_customer(source)
        return card,"old" if card.present?
        return customer.sources.create(source: "#{source.id}"),"new"
      rescue Stripe::StripeError => e
      rescue Exception => e
      raise e.message
    end
  end

  def find_customer(source)
     if user.gateway_customer_id.present?
      customer = Stripe::Customer.retrieve("#{user.gateway_customer_id}")
     else
      customer = Stripe::Customer.create(
        :email => user.email,
        :description => "Customer for #{user.email}",
        :source => "#{source.id}"
      )
      end
      user.update(gateway_customer_id: customer.id)
      return customer
  end

  def paypal_payment(*options)
     cart.paypal_request(options[0][:store_id],options[1])
  end

  def create_paypal_payment(*options)
    cart.setup_payment(options[0][:store_id],options[1],self)
  end

  def gateway_payment_request(*options)

    response = Stripe::Charge.create(
      :amount => options[0].to_i * 100,
      :currency => DEFAULT_CURRENCY,
      :source => "#{options[1]}",
      :capture => true,
      :description => "Charge for as a Firezza Guest User"    
      )
    response
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
