class AddThumbnailToItem < ActiveRecord::Migration[5.0]
  def change
    change_table :items do |t|
      t.string :thumbnail_url
      t.string :wiki_url
    end
  end
end
