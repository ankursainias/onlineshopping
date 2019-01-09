class CreateCouponRedemptions < ActiveRecord::Migration[5.2]
  def change
    create_table :coupon_redemptions do |t|
      t.belongs_to :coupon, null: false
      t.belongs_to :user, null: true
      t.belongs_to :order, null: true
      t.timestamps null: false
    end
  end
end
