class Item < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: {case_sensitive: false}

  VALID_EQUIPMENT_SLOTS = %w[component Potion Bomb Food Steel Silver Ranged Ammo Body Hands Legs Feet]
  validates :slot,
            inclusion: {
              in: VALID_EQUIPMENT_SLOTS,
              message: "%{value} is not a valid slot name"
            }

  VALID_ITEM_TIERS = %w[Common Master Magic Witcher]
  validates :tier,
            inclusion: {
              in: VALID_ITEM_TIERS,
              message: "%{value} is not a valid item tier"
            }

  VALID_ARMOR_TYPES = %w[n/a Light Medium Heavy]
  validates :armor_type,
            inclusion: {
              in: VALID_ARMOR_TYPES,
              message: "%{value} is not a valid armor type"
            }

  VALID_CRAFT_TYPES = %w[component Blacksmith Armorer Alchemy]
  validates :craft_type,
            inclusion: {
              in: VALID_CRAFT_TYPES,
              message: "%{value} is not a valid craft type"
            }

  validates :armor,
            numericality: {
                only_integer: true,
                greater_than_or_equal_to: 0,
                allow_nil: true
            }

  validates :damage_min,
            numericality: {
                only_integer: true,
                greater_than_or_equal_to: 0,
                allow_nil: true
            }

  validates :damage_max,
            numericality: {
                only_integer: true,
                greater_than_or_equal_to: 0,
                allow_nil: true
            }

  validates :val,
            numericality: {
                only_integer: true,
                greater_than_or_equal_to: 0,
                allow_nil: true
            }

  validates :enhancement_slots,
            numericality: {
                only_integer: true,
                greater_than_or_equal_to: 0,
                allow_nil: true
            }

  validates :weight,
            numericality: {
                greater_than_or_equal_to: 0.0
            }

  VALID_IMAGE_SIZE_REGEX = /\A\d+x\d+\z/
  validates :thumbnail_size,
            format: {with: VALID_IMAGE_SIZE_REGEX}

  def small_thumbnail_size
    if thumbnail_size.nil? || thumbnail_size !~ VALID_IMAGE_SIZE_REGEX
      logger.debug('Using default small thumbnail size')
      return '32x32'
    end
    dimensions = thumbnail_size.split('x')
    # For a list view, we want a thumbnail with a vertical size of 32px, with the horizontal scaled accordingly.
    scale = dimensions[1].to_f / 32.0
    small_dimensions = dimensions.map {|d| (d.to_i / scale).floor}.join('x')
    logger.debug("Modifying dimensions (#{thumbnail_size}): #{dimensions} / #{scale} = #{small_dimensions}")
    small_dimensions
  end
end
