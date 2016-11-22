class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredients do |t|
      t.references :item, foreign_key: true
      t.integer :qty
      t.references :recipe, foreign_key: true

      t.timestamps
    end
  end
end
