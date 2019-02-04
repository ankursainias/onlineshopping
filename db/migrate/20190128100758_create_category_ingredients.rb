class CreateCategoryIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :category_ingredients do |t|
      t.references :category, foreign_key: true
      t.references :ingredient, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
