class Recipe < ApplicationRecord
  has_many :ingredients

  VALID_ARTISANS = %w[Armorsmith Blacksmith Alchemy]
  validates :artisan,
            inclusion: {
                in: VALID_ARTISANS,
                message: "%{value} is not a valid artisan type"
            }

  VALID_LEVELS = %w[Amateur Journeyman Master]
  validates :level,
            inclusion: {
                in: VALID_LEVELS,
                message: "%{value} is not a valid craft level"
            }

  def ingredients_cost
    sum = 0
    ingredients.each {|ingredient| sum += ingredient.item.val * ingredient.qty}
    sum
  end

  def total_cost
    ingredients_cost + cost
  end
end
