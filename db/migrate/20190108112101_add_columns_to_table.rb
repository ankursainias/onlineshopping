class AddColumnsToTable < ActiveRecord::Migration[5.2]
  def change
  	add_column :payments, :fee, :float, default: 0
  	add_column :payments, :currency, :string, default: "INR"
  end
end
