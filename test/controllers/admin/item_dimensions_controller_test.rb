require 'test_helper'

class Admin::ItemDimensionsControllerTest < ActionController::TestCase
  setup do
    @item_dimension = item_dimensions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_dimensions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_dimension" do
    assert_difference('ItemDimension.count') do
      post :create, item_dimension: { dimension_id: @item_dimension.dimension_id, item_id: @item_dimension.item_id, price: @item_dimension.price }
    end

    assert_redirected_to admin_item_dimension_path(assigns(:item_dimension))
  end

  test "should show item_dimension" do
    get :show, id: @item_dimension
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_dimension
    assert_response :success
  end

  test "should update item_dimension" do
    patch :update, id: @item_dimension, item_dimension: { dimension_id: @item_dimension.dimension_id, item_id: @item_dimension.item_id, price: @item_dimension.price }
    assert_redirected_to admin_item_dimension_path(assigns(:item_dimension))
  end

  test "should destroy item_dimension" do
    assert_difference('ItemDimension.count', -1) do
      delete :destroy, id: @item_dimension
    end

    assert_redirected_to admin_item_dimensions_path
  end
end
