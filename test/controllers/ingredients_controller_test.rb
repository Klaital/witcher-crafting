require 'test_helper'

class IngredientsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @recipe = recipes(:dimeritium_bomb)
    @ingredient = ingredients(:dimeritium_saltpeter)
  end

  test "should get index" do
    get recipe_ingredients_url(@recipe)
    assert_response :success
  end

  test "should get new when logged in" do
    get login_path
    post login_path, params: {session: {email: @user.email,
                                        password: 'foobar'}}
    get new_recipe_ingredient_url(@recipe)
    assert_response :success
  end

  test "should not get new when not logged in" do
    get new_recipe_ingredient_url(@recipe)
    assert_redirected_to login_path
  end


  test "should create ingredient when logged in" do
    get login_path
    post login_path, params: {session: {email: @user.email,
                                        password: 'foobar'}}
    assert_difference('Ingredient.count') do
      post recipe_ingredients_url(@recipe), params: { ingredient: { item_id: @ingredient.item_id, qty: @ingredient.qty, recipe_id: @ingredient.recipe_id } }
    end

    assert_redirected_to recipe_ingredient_url(@recipe, Ingredient.last)
  end

  test "should not create ingredient when not logged in" do
    assert_no_difference('Ingredient.count') do
      post recipe_ingredients_url(@recipe), params: { ingredient: { item_id: @ingredient.item_id, qty: @ingredient.qty, recipe_id: @ingredient.recipe_id } }
    end

    assert_response(401)
  end

  test "should show ingredient" do
    get recipe_ingredient_url(@recipe, @ingredient)
    assert_response :success
  end

  test "should get edit when logged in" do
    get login_path
    post login_path, params: {session: {email: @user.email,
                                        password: 'foobar'}}
    get edit_recipe_ingredient_url(@recipe, @ingredient)
    assert_response :success
  end

  test "should not get edit when not logged in" do
    get edit_recipe_ingredient_url(@recipe, @ingredient)
    assert_redirected_to login_path
  end

  test "should update ingredient when logged in" do
    get login_path
    post login_path, params: {session: {email: @user.email,
                                        password: 'foobar'}}
    patch recipe_ingredient_url(@recipe, @ingredient), params: { ingredient: { item_id: @ingredient.item_id, qty: @ingredient.qty, recipe_id: @ingredient.recipe_id } }
    assert_redirected_to recipe_ingredient_url(@recipe, @ingredient)
  end

  test "should not update ingredient when not logged in" do
    patch recipe_ingredient_url(@recipe, @ingredient), params: { ingredient: { item_id: @ingredient.item_id, qty: @ingredient.qty, recipe_id: @ingredient.recipe_id } }
    assert_response(401)
  end

  test "should destroy ingredient when logged in" do
    get login_path
    post login_path, params: {session: {email: @user.email,
                                        password: 'foobar'}}
    assert_difference('Ingredient.count', -1) do
      delete recipe_ingredient_url(@recipe, @ingredient)
    end

    assert_redirected_to recipe_ingredients_url(@recipe)
  end

  test "should not destroy ingredient when not logged in" do
    assert_no_difference('Ingredient.count') do
      delete recipe_ingredient_url(@recipe, @ingredient)
    end
    assert_response(401)
  end
end
