class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.references :user, foreign_key: true
      t.string :gateway_card_id
      t.string :exp_month
      t.string :exp_year
      t.string :last4
      t.string :card_type
      t.boolean :default, default: true

      t.timestamps
    end
    add_column :users, :gateway_customer_id, :string
  end
end
