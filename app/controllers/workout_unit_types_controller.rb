class WorkoutUnitTypesController < ApplicationController
  before_action :set_workout_unit_type, only: [:show, :edit, :update, :destroy]

  # GET /workout_unit_types
  # GET /workout_unit_types.json
  def index
    @workout_unit_types = WorkoutUnitType.all
  end

  # GET /workout_unit_types/1
  # GET /workout_unit_types/1.json
  def show
  end

  # GET /workout_unit_types/new
  def new
    @workout_unit_type = WorkoutUnitType.new
  end

  # GET /workout_unit_types/1/edit
  def edit
  end

  # POST /workout_unit_types
  # POST /workout_unit_types.json
  def create
    @workout_unit_type = WorkoutUnitType.new(workout_unit_type_params)

    respond_to do |format|
      if @workout_unit_type.save
        format.html { redirect_to @workout_unit_type, notice: 'Workout unit type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @workout_unit_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @workout_unit_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workout_unit_types/1
  # PATCH/PUT /workout_unit_types/1.json
  def update
    respond_to do |format|
      if @workout_unit_type.update(workout_unit_type_params)
        format.html { redirect_to @workout_unit_type, notice: 'Workout unit type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @workout_unit_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workout_unit_types/1
  # DELETE /workout_unit_types/1.json
  def destroy
    @workout_unit_type.destroy
    respond_to do |format|
      format.html { redirect_to workout_unit_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout_unit_type
      @workout_unit_type = WorkoutUnitType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workout_unit_type_params
      params.require(:workout_unit_type).permit(:name, :category, :difficulty, :description, :icon, :color)
    end
end
