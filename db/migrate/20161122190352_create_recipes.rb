class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.references :item
      t.string :level
      t.string :artisan
      t.integer :cost
      t.string :comments

      t.timestamps
    end
  end
end
