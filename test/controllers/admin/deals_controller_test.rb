require 'test_helper'

class Admin::DealsControllerTest < ActionController::TestCase
  setup do
    @deal = deals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:deals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deal" do
    assert_difference('Deal.count') do
      post :create, deal: { amount: @deal.amount, description: @deal.description, end_time: @deal.end_time, image: @deal.image, initial_time: @deal.initial_time, name: @deal.name, price_id: @deal.price_id }
    end

    assert_redirected_to admin_deal_path(assigns(:deal))
  end

  test "should show deal" do
    get :show, id: @deal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @deal
    assert_response :success
  end

  test "should update deal" do
    patch :update, id: @deal, deal: { amount: @deal.amount, description: @deal.description, end_time: @deal.end_time, image: @deal.image, initial_time: @deal.initial_time, name: @deal.name, price_id: @deal.price_id }
    assert_redirected_to admin_deal_path(assigns(:deal))
  end

  test "should destroy deal" do
    assert_difference('Deal.count', -1) do
      delete :destroy, id: @deal
    end

    assert_redirected_to admin_deals_path
  end
end
