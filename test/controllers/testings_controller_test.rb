require 'test_helper'

class TestingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @testing = testings(:one)
  end

  test "should get index" do
    get testings_url
    assert_response :success
  end

  test "should get new" do
    get new_testing_url
    assert_response :success
  end

  test "should create testing" do
    assert_difference('Testing.count') do
      post testings_url, params: { testing: { name: @testing.name } }
    end

    assert_redirected_to testing_url(Testing.last)
  end

  test "should show testing" do
    get testing_url(@testing)
    assert_response :success
  end

  test "should get edit" do
    get edit_testing_url(@testing)
    assert_response :success
  end

  test "should update testing" do
    patch testing_url(@testing), params: { testing: { name: @testing.name } }
    assert_redirected_to testing_url(@testing)
  end

  test "should destroy testing" do
    assert_difference('Testing.count', -1) do
      delete testing_url(@testing)
    end

    assert_redirected_to testings_url
  end
end
