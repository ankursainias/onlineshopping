require 'test_helper'

class Admin::OpenHoursControllerTest < ActionController::TestCase
  setup do
    @open_hour = open_hours(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:open_hours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create open_hour" do
    assert_difference('OpenHour.count') do
      post :create, open_hour: { close: @open_hour.close, day: @open_hour.day, open: @open_hour.open, store_id: @open_hour.store_id, valid_from: @open_hour.valid_from, valid_through: @open_hour.valid_through }
    end

    assert_redirected_to admin_open_hour_path(assigns(:open_hour))
  end

  test "should show open_hour" do
    get :show, id: @open_hour
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @open_hour
    assert_response :success
  end

  test "should update open_hour" do
    patch :update, id: @open_hour, open_hour: { close: @open_hour.close, day: @open_hour.day, open: @open_hour.open, store_id: @open_hour.store_id, valid_from: @open_hour.valid_from, valid_through: @open_hour.valid_through }
    assert_redirected_to admin_open_hour_path(assigns(:open_hour))
  end

  test "should destroy open_hour" do
    assert_difference('OpenHour.count', -1) do
      delete :destroy, id: @open_hour
    end

    assert_redirected_to admin_open_hours_path
  end
end
