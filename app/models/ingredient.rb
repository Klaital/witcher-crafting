class Ingredient < ApplicationRecord
  belongs_to :recipe

  def item
    Item.find(item_id)
  end

  def cost
    item.val.to_i * qty
  end
end
