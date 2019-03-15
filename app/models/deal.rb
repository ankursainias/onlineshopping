class Deal < ApplicationRecord
  belongs_to :price
  has_many :deal_items, dependent: :destroy
  has_many :items, through: :deal_items, source: :item
  has_one :picture, as: :imageable, dependent: :destroy
 	scope :active, -> { where("end_time >= ?", Time.now) }

 	def validate_and_apply(cart)
 		begin
 			raise "Deal either expired or not started!" unless (!expired? && started?)
 			s1 = (items.ids).to_set
 			s2 = (cart.items.ids).to_set
	 		if s2.subset?(s1)
	 			options = {}
	  		options[:amount] = cart.total
	 			return apply(options)
	 		else
	 			raise "Missing some items to apply this deal"
	 		end
 		rescue Exception => e
 			raise e.message
 		end
 	end

 	def expired?
    end_time && end_time < Date.current
  end

 	def started?
    initial_time <= Time.current
  end
 	
	private

 	def apply(options)
    input_amount = BigDecimal("#{options[:amount]}")
    discount = BigDecimal(percentage_based? ? percentage_discount(input_amount) : input_amount)
    total = [0, input_amount - discount].max
    options = options.merge(total: total, discount: discount)
    options
  end

  def percentage_based?
     price.p_type == 'percentage'
  end

	def amount_based?
	  price.p_type == 'amount'
	end

 	def percentage_discount(input_amount)
 			BigDecimal("#{input_amount}") * (BigDecimal("#{amount}") / 100)
 	end

end
