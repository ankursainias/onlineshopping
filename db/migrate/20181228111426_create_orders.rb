class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.references :order_status, foreign_key: true
      t.datetime :expected_delivery_at
      t.datetime :cancelled_at
      t.references :cart, foreign_key: true
      t.float :delivery_fee, default: 0
      t.float :sub_total, default: 0
      t.float :discount_total, default: 0
      t.float :grand_total, default: 0

      t.timestamps
    end
  end
end
