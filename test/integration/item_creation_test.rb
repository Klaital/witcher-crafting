require 'test_helper'

class ItemCreationTest < ActionDispatch::IntegrationTest
  def setup
    # Log in a valid user
    @user = users(:one)
    @item = items(:dimeritium_bomb)
    post login_path, params: {session: {email: @user.email, password: 'foobar'}}
  end

  test "create a new item" do
    assert is_logged_in?
    get new_item_path
    assert_template 'items/new'
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

    new_item = Item.last
    assert_redirected_to item_url(new_item)
    follow_redirect!
    assert_template 'items/show'

    assert_not_empty flash[:notice]
    # An item's show page should have the following links
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_item_path(new_item)
    assert_select "a[href=?]", items_path
    assert_select "a[href=?]", new_recipe_path(:produces => new_item.id)
  end
end
