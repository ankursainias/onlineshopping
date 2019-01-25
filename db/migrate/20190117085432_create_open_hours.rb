class CreateOpenHours < ActiveRecord::Migration[5.2]
  def change
    create_table :open_hours do |t|
      t.references :store, foreign_key: true
      t.integer :day
      t.time :close
      t.time :open
      t.datetime :valid_from
      t.datetime :valid_through

      t.timestamps
    end
  end
end
