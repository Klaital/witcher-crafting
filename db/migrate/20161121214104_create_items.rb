class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :slot
      t.string :tier
      t.string :craft_type # blacksmith, swordsmith, alchemist
      t.integer :armor
      t.integer :damage_min
      t.integer :damage_max
      t.integer :val
      t.integer :enhancement_slots
      t.string :other_effects
      t.string :comments

      t.timestamps
    end
  end
end
