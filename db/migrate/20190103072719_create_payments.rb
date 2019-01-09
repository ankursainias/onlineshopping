class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :order, foreign_key: true
      t.string :transaction_id
      t.datetime :pay_time
      t.references :card, foreign_key: true
      t.string :failure_message
      t.string :failure_code
      t.string :gateway_status
      t.boolean :captrued, default: false
      t.string :pay_type

      t.timestamps
    end
  end
end
