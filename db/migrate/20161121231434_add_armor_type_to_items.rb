class AddArmorTypeToItems < ActiveRecord::Migration[5.0]
  def change
    change_table :items do |t|
      t.string :armor_type
    end
  end
end
