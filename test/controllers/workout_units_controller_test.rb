require 'test_helper'

class WorkoutUnitsControllerTest < ActionController::TestCase
  setup do
    @workout_unit = workout_units(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workout_units)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workout_unit" do
    assert_difference('WorkoutUnit.count') do
      post :create, workout_unit: { date: @workout_unit.date, workout_unit_type_id: @workout_unit.workout_unit_type_id }
    end

    assert_redirected_to workout_unit_path(assigns(:workout_unit))
  end

  test "should show workout_unit" do
    get :show, id: @workout_unit
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @workout_unit
    assert_response :success
  end

  test "should update workout_unit" do
    patch :update, id: @workout_unit, workout_unit: { date: @workout_unit.date, workout_unit_type_id: @workout_unit.workout_unit_type_id }
    assert_redirected_to workout_unit_path(assigns(:workout_unit))
  end

  test "should destroy workout_unit" do
    assert_difference('WorkoutUnit.count', -1) do
      delete :destroy, id: @workout_unit
    end

    assert_redirected_to workout_units_path
  end
end
