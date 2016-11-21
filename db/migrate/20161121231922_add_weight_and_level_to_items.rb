class AddWeightAndLevelToItems < ActiveRecord::Migration[5.0]
  def change
    change_table :items do |t|
      t.float :weight
      t.integer :level_requirement
    end
  end
end
