class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  def total
  		total = 0
  		cart_items.each do |cart_item|
  			total = total + (ItemDimension.find(cart_item.item_dimension_id).price * cart_item.quantity)
  		end
  		return total
  end

  def items
    cart_items
  end

  def paypal_url(root_url,notify_url,cancel_return)
    values = {
      :business => 'ankur+facilitator@poplify.com',
      :cmd=>'_cart',
      :rm => '2',
      :upload => 1,
      :notify_url => root_url,
      :return => "#{root_url}home/paypal_notify",
      :invoice => id,
      :cancel_return => "#{root_url}"+cancel_return,
      :currency_code => "GBP"
    }
    
    cart_items.each_with_index do |cart_item, index|
      values.merge!({
        "amount_#{index + 1}" => cart_item.sub_total,
        "item_name_#{index + 1}" => cart_item.item.name,
        "quantity_#{index + 1}" => cart_item.quantity,
      })
    end
    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

end
