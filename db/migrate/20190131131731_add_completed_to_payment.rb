class AddCompletedToPayment < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :completed, :boolean, default: false
  end
end
