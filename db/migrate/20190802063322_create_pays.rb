class CreatePays < ActiveRecord::Migration[5.2]
  def change
    create_table :pays do |t|

      t.timestamps
    end
  end
end
