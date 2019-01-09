require 'test_helper'

class Admin::OrdersControllerTest < ActionController::TestCase
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post :create, order: { cancelled_at: @order.cancelled_at, cart_id: @order.cart_id, delivery_fee: @order.delivery_fee, discount_total: @order.discount_total, expected_delivery_at: @order.expected_delivery_at, grand_total: @order.grand_total, order_status_id: @order.order_status_id, sub_total: @order.sub_total, user_id: @order.user_id }
    end

    assert_redirected_to admin_order_path(assigns(:order))
  end

  test "should show order" do
    get :show, id: @order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @order
    assert_response :success
  end

  test "should update order" do
    patch :update, id: @order, order: { cancelled_at: @order.cancelled_at, cart_id: @order.cart_id, delivery_fee: @order.delivery_fee, discount_total: @order.discount_total, expected_delivery_at: @order.expected_delivery_at, grand_total: @order.grand_total, order_status_id: @order.order_status_id, sub_total: @order.sub_total, user_id: @order.user_id }
    assert_redirected_to admin_order_path(assigns(:order))
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete :destroy, id: @order
    end

    assert_redirected_to admin_orders_path
  end
end
