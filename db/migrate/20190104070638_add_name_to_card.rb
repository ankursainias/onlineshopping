class AddNameToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :name, :string
  end
end
