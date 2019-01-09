class AddStateToDeliveryAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :delivery_addresses, :state, :string
  end
end
