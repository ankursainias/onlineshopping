class AddFingerPrintToCard < ActiveRecord::Migration[5.2]
  def change
    add_column :cards, :fingerprint, :string
  end
end
