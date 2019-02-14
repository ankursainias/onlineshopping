require 'test_helper'

class Admin::DealItemsControllerTest < ActionController::TestCase
  setup do
    @deal_item = deal_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deal_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deal_item" do
    assert_difference('DealItem.count') do
      post :create, deal_item: { deal_id: @deal_item.deal_id, item_id: @deal_item.item_id }
    end

    assert_redirected_to admin_deal_item_path(assigns(:deal_item))
  end

  test "should show deal_item" do
    get :show, id: @deal_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @deal_item
    assert_response :success
  end

  test "should update deal_item" do
    patch :update, id: @deal_item, deal_item: { deal_id: @deal_item.deal_id, item_id: @deal_item.item_id }
    assert_redirected_to admin_deal_item_path(assigns(:deal_item))
  end

  test "should destroy deal_item" do
    assert_difference('DealItem.count', -1) do
      delete :destroy, id: @deal_item
    end

    assert_redirected_to admin_deal_items_path
  end
end
