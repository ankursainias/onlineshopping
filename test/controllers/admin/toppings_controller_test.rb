require 'test_helper'

class Admin::ToppingsControllerTest < ActionController::TestCase
  setup do
    @topping = toppings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:toppings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topping" do
    assert_difference('Topping.count') do
      post :create, topping: { active: @topping.active, name: @topping.name, price: @topping.price }
    end

    assert_redirected_to admin_topping_path(assigns(:topping))
  end

  test "should show topping" do
    get :show, id: @topping
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @topping
    assert_response :success
  end

  test "should update topping" do
    patch :update, id: @topping, topping: { active: @topping.active, name: @topping.name, price: @topping.price }
    assert_redirected_to admin_topping_path(assigns(:topping))
  end

  test "should destroy topping" do
    assert_difference('Topping.count', -1) do
      delete :destroy, id: @topping
    end

    assert_redirected_to admin_toppings_path
  end
end
