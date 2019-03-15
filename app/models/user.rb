class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :carts, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, -> { order "created_at DESC" }, dependent: :destroy
  has_many :coupon_redemptions, dependent: :destroy
  has_many :delivery_addresses, dependent: :destroy
  has_many :cards, dependent: :destroy
   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  before_save { self.email = email.downcase }                  
  
  def set_default_role
    self.role ||= :user
  end

  def set_cart_items(old_session_id)
    unless self.admin?
      @new_cart = Cart.find_by(session_id: old_session_id, purchased: false)
      if @new_cart.present?
        @old_cart = Cart.find_by(user_id: self.id, purchased: false)
        if @old_cart.present?
          @new_cart_items = @new_cart.cart_items
          @new_cart_items.update_all(user_id: self.id,cart_id: @old_cart.id)
          @new_cart.destroy
        else
          @new_cart.update!(user_id: self.id)
          @old_cart = @new_cart
        end
      end
    end
  end

  def testing(arr)  
      sub_ary = arr.uniq
      main_ary = []
      sub_ary.each do |el|
        element =  arr.max_by { |i| arr.count(i) }
        main_ary.push(element)
        arr.delete(element)
      end
      main_ary
  end
  
end
