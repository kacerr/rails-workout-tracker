require 'test_helper'

class WorkoutUnitTypesControllerTest < ActionController::TestCase
  setup do
    @workout_unit_type = workout_unit_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workout_unit_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workout_unit_type" do
    assert_difference('WorkoutUnitType.count') do
      post :create, workout_unit_type: { category: @workout_unit_type.category, description: @workout_unit_type.description, difficulty: @workout_unit_type.difficulty, icon: @workout_unit_type.icon, name: @workout_unit_type.name }
    end

    assert_redirected_to workout_unit_type_path(assigns(:workout_unit_type))
  end

  test "should show workout_unit_type" do
    get :show, id: @workout_unit_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @workout_unit_type
    assert_response :success
  end

  test "should update workout_unit_type" do
    patch :update, id: @workout_unit_type, workout_unit_type: { category: @workout_unit_type.category, description: @workout_unit_type.description, difficulty: @workout_unit_type.difficulty, icon: @workout_unit_type.icon, name: @workout_unit_type.name }
    assert_redirected_to workout_unit_type_path(assigns(:workout_unit_type))
  end

  test "should destroy workout_unit_type" do
    assert_difference('WorkoutUnitType.count', -1) do
      delete :destroy, id: @workout_unit_type
    end

    assert_redirected_to workout_unit_types_path
  end
end
