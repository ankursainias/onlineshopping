require 'test_helper'

class Admin::CouponsControllerTest < ActionController::TestCase
  setup do
    @coupon = coupons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:coupons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create coupon" do
    assert_difference('Coupon.count') do
      post :create, coupon: { amount: @coupon.amount, c_type: @coupon.c_type, code: @coupon.code, coupon_redemptions_count: @coupon.coupon_redemptions_count, description: @coupon.description, redemption_limit: @coupon.redemption_limit, valid_from: @coupon.valid_from, valid_until: @coupon.valid_until }
    end

    assert_redirected_to admin_coupon_path(assigns(:coupon))
  end

  test "should show coupon" do
    get :show, id: @coupon
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @coupon
    assert_response :success
  end

  test "should update coupon" do
    patch :update, id: @coupon, coupon: { amount: @coupon.amount, c_type: @coupon.c_type, code: @coupon.code, coupon_redemptions_count: @coupon.coupon_redemptions_count, description: @coupon.description, redemption_limit: @coupon.redemption_limit, valid_from: @coupon.valid_from, valid_until: @coupon.valid_until }
    assert_redirected_to admin_coupon_path(assigns(:coupon))
  end

  test "should destroy coupon" do
    assert_difference('Coupon.count', -1) do
      delete :destroy, id: @coupon
    end

    assert_redirected_to admin_coupons_path
  end
end
