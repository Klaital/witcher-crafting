require 'test_helper'

class RecipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @recipe = recipes(:dimeritium_bomb)
  end

  test "should get index" do
    get recipes_url
    assert_response :success
  end

  test "should show recipe" do
    get recipe_url(@recipe)
    assert_response :success
    end

  test "should get new when logged in" do
    post login_path, params: {session: {email: @user.email, password: 'foobar'}}
    get new_recipe_url
    assert_response :success
  end
  test "should not get new when not logged in" do
    get new_recipe_url
    assert_redirected_to login_path
  end

  test "should create recipe when logged in" do
    post login_path, params: {session: {email: @user.email, password: 'foobar'}}
    assert_difference('Recipe.count') do
      post recipes_url, params: { recipe: { artisan: @recipe.artisan, cost: @recipe.cost, item_id: @recipe.item_id, level: @recipe.level } }
    end

    recipe = Recipe.last
    item = Item.find(recipe.item_id)
    assert_redirected_to item_url(item)
  end
  test "should not create recipe when not logged in" do
    assert_no_difference('Recipe.count') do
      post recipes_url, params: { recipe: { artisan: @recipe.artisan, cost: @recipe.cost, item_id: @recipe.item_id, level: @recipe.level } }
    end
    assert_response(401)
  end

  test "should get edit when logged in" do
    post login_path, params: {session: {email: @user.email, password: 'foobar'}}
    get edit_recipe_url(@recipe)
    assert_response :success
  end

  test "should not get edit when not logged in" do
    get edit_recipe_url(@recipe)
    assert_redirected_to login_url
  end

  test "should update recipe when logged in" do
    post login_path, params: {session: {email: @user.email, password: 'foobar'}}
    patch recipe_url(@recipe), params: { recipe: { artisan: @recipe.artisan, cost: @recipe.cost, item_id: @recipe.item_id, level: @recipe.level } }
    assert_redirected_to item_url(Item.find(@recipe.item_id))
  end
  test "should not update recipe when not logged in" do
    patch recipe_url(@recipe), params: { recipe: { artisan: @recipe.artisan, cost: @recipe.cost, item_id: @recipe.item_id, level: @recipe.level } }
    assert_response(401)
  end

  test "should destroy recipe when logged in" do
    post login_path, params: {session: {email: @user.email, password: 'foobar'}}
    assert_difference('Recipe.count', -1) do
      delete recipe_url(@recipe)
    end

    assert_redirected_to item_url(Item.find(@recipe.item_id))
  end

  test "should not destroy recipe when not logged in" do
    assert_no_difference('Recipe.count') do
      delete recipe_url(@recipe)
    end

    assert_response(401)
  end
end
