require 'test_helper'

class UserMeasurementsControllerTest < ActionController::TestCase
  setup do
    @user_measurement = user_measurements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_measurements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_measurement" do
    assert_difference('UserMeasurement.count') do
      post :create, user_measurement: { measurement_id: @user_measurement.measurement_id, note: @user_measurement.note, user_id: @user_measurement.user_id, value: @user_measurement.value, value_string: @user_measurement.value_string }
    end

    assert_redirected_to user_measurement_path(assigns(:user_measurement))
  end

  test "should show user_measurement" do
    get :show, id: @user_measurement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_measurement
    assert_response :success
  end

  test "should update user_measurement" do
    patch :update, id: @user_measurement, user_measurement: { measurement_id: @user_measurement.measurement_id, note: @user_measurement.note, user_id: @user_measurement.user_id, value: @user_measurement.value, value_string: @user_measurement.value_string }
    assert_redirected_to user_measurement_path(assigns(:user_measurement))
  end

  test "should destroy user_measurement" do
    assert_difference('UserMeasurement.count', -1) do
      delete :destroy, id: @user_measurement
    end

    assert_redirected_to user_measurements_path
  end
end
