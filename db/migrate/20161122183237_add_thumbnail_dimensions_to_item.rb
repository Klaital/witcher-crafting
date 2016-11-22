class AddThumbnailDimensionsToItem < ActiveRecord::Migration[5.0]
  def change
    change_table :items do |t|
      t.string :thumbnail_size
    end
  end
end
