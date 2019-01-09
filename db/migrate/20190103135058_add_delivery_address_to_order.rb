class AddDeliveryAddressToOrder < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :delivery_address, foreign_key: true
  end
end
