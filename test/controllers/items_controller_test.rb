require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @item = items(:dimeritium_bomb)
  end

  # The index and show actions should be public - no login required.
  test "should get index" do
    get items_url
    assert_response :success
  end

  test "should show item" do
    get item_url(@item)
    assert_response :success
  end

  # The database-altering actions should all require a login

  test "should get new when logged in" do
    post login_path, params: {session: {email: @user.email,
                                        password: 'foobar'}}
    get new_item_url
    assert_response :success
  end
  test "should not get new when not logged in" do
    get new_item_url
    assert_redirected_to login_path
  end

  test "should create item when logged in" do
    post login_path, params: {session: {email: @user.email,
                                        password: 'foobar'}}
    follow_redirect!
    assert_difference('Item.count') do
      post items_url, params: { item: {
          name: @item.name+' a',
          val: @item.val,
          slot: @item.slot,
          tier: @item.tier,
          craft_type: @item.craft_type,
          armor_type: @item.armor_type,
          weight: @item.weight,
          thumbnail_size: @item.thumbnail_size,
      } }
    end

    assert_redirected_to item_url(Item.last)
  end

  test "should not create item when not logged in" do
    assert_no_difference('Item.count') do
      post items_url, params: { item: { name: @item.name+'a', val: @item.val, slot: @item.slot, tier: @item.tier, craft_type: @item.craft_type } }
    end
    assert_response(401)
  end

  test "should get edit when logged in" do
    post login_path, params: {session: {email: @user.email,
                                        password: 'foobar'}}
    get edit_item_url(@item)
    assert_response :success
  end

  test "should not get edit when not logged in" do
    get edit_item_url(@item)
    assert_redirected_to login_path
  end

  test "should update item when logged in" do
    post login_path, params: {session: {email: @user.email, password: 'foobar'}}
    patch item_url(@item), params: { item: {
        name: @item.name+' aa',
        val: @item.val,
        slot: @item.slot,
        tier: @item.tier,
        craft_type: @item.craft_type,
        armor_type: @item.armor_type,
        weight: @item.weight,
        thumbnail_size: @item.thumbnail_size,
    } }
    assert_redirected_to item_url(@item)
  end

  test "should not update item when not logged in" do
    patch item_url(@item), params: { item: {
        name: @item.name+' a',
        val: @item.val,
        slot: @item.slot,
        tier: @item.tier,
        craft_type: @item.craft_type,
        armor_type: @item.armor_type,
        weight: @item.weight,
        thumbnail_size: @item.thumbnail_size,
    } }
    assert_response(401)
  end

  test "should destroy item when logged in" do
    post login_path, params: {session: {email: @user.email, password: 'foobar'}}
    assert_difference('Item.count', -1) do
      delete item_url(@item)
    end

    assert_redirected_to items_url
  end

  test "should not destroy item not when logged in" do
    assert_no_difference('Item.count') do
      delete item_url(@item)
    end
    assert_response(401)
  end
end
