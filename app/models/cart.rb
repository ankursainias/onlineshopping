class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items
  has_many :orders, dependent: :destroy

  def total
  		total = 0
  		cart_items.each do |cart_item|
  			total = total + (ItemDimension.find(cart_item.item_dimension_id).price * cart_item.quantity)
        total = total + cart_item.toppings_price
  		end
  		return total
  end

  # def items
  #   cart_items
  # end

  def setup_payment(*options)
    begin
       require 'paypal-sdk-rest'
       set_configrations
       # Build Payment object
      @paypal_payment = PayPal::SDK::REST::Payment.new({
        :rm => 2,
        :intent =>  "sale",
        :payer =>  {
          :payment_method =>  "paypal" },
        :redirect_urls => {
          :return_url => return_url(options[1],options[0]),
          :cancel_url => cancel_url(options[1],options[0])},
        :transactions =>  [{
          :item_list => {
            :items => item_list},
          :amount =>  {
            :total =>  "#{total}",
            :currency =>  "GBP" },
          :description =>  "This is the payment transaction description." }]})
      @paypal_payment.create!
      initialize_payment(@paypal_payment,options[2])
       @paypal_payment.links.find{|v| v.rel == "approval_url" }.href
    rescue PayPal::SDK::Core::Exceptions::UnsuccessfulApiCall => e
    rescue Exception => e
      raise e.message
    end
      
  end

  def return_url(root_url,id)
    "#{root_url}api/stores/#{id}/orders/paypal_success"
  end

  def cancel_url(root_url,id)
    "#{root_url}api/stores/#{id}/orders/paypal_cancel"
  end

  def initialize_payment(*options)
      payment_params = {}
      payment_params[:transaction_id] = options[0].id
      payment_params[:token] = options[0].token
      payment_params[:failure_message] = options[0].failure_reason
      payment_params[:failure_code] = options[0].raise_error!
      payment_params[:gateway_status] = options[0].state
      payment_params[:pay_type] = "Paypal"
      payment_params[:currency] = options[0].transactions.last.amount.currency
      @payment = options[1].payments.new(payment_params)
      @payment.save!
  end

  def item_list
    itemList = []
    cart_items.each_with_index do |cart_item,index|
        item =   {
              :name => cart_item.item.name,
              :sku => "Item_#{cart_item.item_id}",
              :price => "#{cart_item.sub_total}",
              :currency => "GBP",
              :quantity => cart_item.quantity 
            }
        itemList.push(item)
       toppings =  Topping.where(id: cart_item.topping_ids)
       toppings.each_with_index do |topping,index|
        item =   {
              :name => topping.name,
              :sku => "Topping of #{cart_item.item.name} item",
              :price => "#{topping.price}",
              :currency => "GBP",
              :quantity => 1
            }
        itemList.push(item)      
       end    
    end
    itemList
  end

  def paypal_request(store_id,root_url)
    values = {
      :business => 'ankur+facilitator@poplify.com',
      :cmd=>'_cart',
      :rm => '2',
      :upload => 1,
      :notify_url => "#{root_url}api/stores/#{store_id}/orders/paypal_success",
      :return => "#{root_url}api/stores/#{store_id}/orders/paypal_obj",
      :invoice => id,
      :cancel_return => "#{root_url}api/stores/#{store_id}/orders/paypal_cancel",
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

  private 

  def set_configrations
    PayPal::SDK::REST.set_config(
        :mode => "sandbox", # "sandbox" or "live"
        :client_id => "AcPm6wWjofEjPmHVVxFHGZBvQoLsyAYdSZ6ljSAlBywIziQmhhivBHrvJzG5jXQZMpoXmZRT3JhdkiOk",
        :client_secret => "EDo3bZ7UXXd6DZ-VpbsjYXECQp4g2OcQPEn2KXDMT7qkTt6SPT-Xps6FEgD0LhlGvr0fzZpQgxy-2tI7")
  end

end
