require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  test "the recipe should compute its ingredient costs correctly" do
    r = recipes(:dimeritium_bomb)
    assert_equal(70, r.ingredients_cost)
  end

  test "the recipe should compute its ingredient costs correctly when some are unknown" do
    r = recipes(:silver_ingot)
    assert_equal(0, r.ingredients_cost)
  end

  test "the recipe should compute its total cost correctly" do
    r = recipes(:dimeritium_bomb)
    assert_equal(70, r.ingredients_cost)
    assert_equal(70, r.total_cost)
    r.cost = 15
    assert_equal(85, r.total_cost)
  end
end
