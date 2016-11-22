class Ingredient < ApplicationRecord
  belongs_to :recipe

  def item
    Item.find(item_id)
  end
end
