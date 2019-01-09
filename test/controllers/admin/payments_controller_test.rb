require 'test_helper'

class Admin::PaymentsControllerTest < ActionController::TestCase
  setup do
    @payment = payments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:payments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create payment" do
    assert_difference('Payment.count') do
      post :create, payment: { captrued: @payment.captrued, card_id: @payment.card_id, failure_code: @payment.failure_code, failure_message: @payment.failure_message, gateway_status: @payment.gateway_status, order_id: @payment.order_id, pay_time: @payment.pay_time, pay_type: @payment.pay_type, transaction_id: @payment.transaction_id }
    end

    assert_redirected_to admin_payment_path(assigns(:payment))
  end

  test "should show payment" do
    get :show, id: @payment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @payment
    assert_response :success
  end

  test "should update payment" do
    patch :update, id: @payment, payment: { captrued: @payment.captrued, card_id: @payment.card_id, failure_code: @payment.failure_code, failure_message: @payment.failure_message, gateway_status: @payment.gateway_status, order_id: @payment.order_id, pay_time: @payment.pay_time, pay_type: @payment.pay_type, transaction_id: @payment.transaction_id }
    assert_redirected_to admin_payment_path(assigns(:payment))
  end

  test "should destroy payment" do
    assert_difference('Payment.count', -1) do
      delete :destroy, id: @payment
    end

    assert_redirected_to admin_payments_path
  end
end
