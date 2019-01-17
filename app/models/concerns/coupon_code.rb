module CouponCode
	extend ActiveSupport::Concern
	included do
		validates :c_type, inclusion: { in: %w(Percentage Amount )}
		validates_date_of :valid_from, after_or_equal_to:  Proc.new { Date.today}, on: :create
		validates_date_of :valid_until, after_or_equal_to: :valid_from, on: :create
		validates_presence_of :code, :valid_from
		validates_numericality_of :amount,
	        greater_than_or_equal_to: 0,
	        less_than_or_equal_to: 100,
	        only_integer: true,
	        if: :percentage_based?

	      validates_numericality_of :amount,
	        greater_than_or_equal_to: 0,
	        only_integer: true,
	        if: :amount_based?

	      validates_numericality_of :redemption_limit,
	        only_integer: true,
	        greater_than_or_equal_to: 0

	    validate :validate_dates, on: :create    
		  after_initialize do
			  self.code ||= Coupon.genrator_call
			  self.valid_from ||= Date.current
			end

	end

	def coupon_type_is_percentage
		return true if self.c_type.to_s.downcase! == "percentage"
		return false
	end

	def apply(options)
    input_amount = BigDecimal("#{options[:amount]}")
    discount = BigDecimal(percentage_based? ? percentage_discount(input_amount) : input_amount)
    total = [0, input_amount - discount].max
    options = options.merge(total: total, discount: discount)
    options
  end

  def redemptions_count
    coupon_redemptions_count
  end

  def has_available_redemptions?
    redemptions_count.zero? || redemptions_count < redemption_limit
  end

  def started?
    valid_from <= Date.current
  end

  def redeemable?
    !expired? && has_available_redemptions? && started?
  end

	def percentage_based?
     c_type == 'Percentage'
  end

	def amount_based?
	  c_type == 'Amount'
	end

	def expired?
    valid_until && valid_until < Date.current
  end

  def failure_terms
  	raise "Coupon already expired" if expired?
  	raise "Coupon already redemptions" unless has_available_redemptions?
  end

  private

  def percentage_discount(input_amount)
    BigDecimal("#{input_amount}") * (BigDecimal("#{amount}") / 100)
  end

 def validate_dates
    if valid_until_before_type_cast.present?
      errors.add(:valid_until, :invalid) unless valid_until.kind_of?(Date)
      errors.add(:valid_until, :coupon_already_expired) if valid_until? && valid_until < Date.current
    end

    if valid_from.present? && valid_until.present?
      errors.add(:valid_until, :coupon_valid_until) if valid_until < valid_from
    end
  end

  module ClassMethods
		def genrator_call
			token = SecureRandom.hex[0, 4].upcase
	    	"PRZA#{token}"
		end	
	end

end