class WorkoutUnitsController < ApplicationController
  before_action :set_workout_unit, only: [:show, :edit, :update, :destroy]

  # GET /workout_units
  # GET /workout_units.json
  def index
    @workout_units = WorkoutUnit.all
  end

  # GET /workout_units/1
  # GET /workout_units/1.json
  def show
  end

  # GET /workout_units/new
  def new
    @workout_unit = WorkoutUnit.new
  end

  # GET /workout_units/1/edit
  def edit
  end

  # POST /workout_units
  # POST /workout_units.json
  def create
    @workout_unit = WorkoutUnit.new(workout_unit_params)
    @workout_unit.user_id = current_user.id
    respond_to do |format|
      if @workout_unit.save
        format.html { redirect_to @workout_unit, notice: 'Workout unit was successfully created.' }
        format.json { 
          render :json => @workout_unit.as_json(:include => :workout_unit_type), action: 'show', status: :created, location: @workout_unit 
        }
      else
        format.html { render action: 'new' }
        format.json { render json: @workout_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workout_units/1
  # PATCH/PUT /workout_units/1.json
  def update
    respond_to do |format|
      if @workout_unit.update(workout_unit_params)
        format.html { redirect_to @workout_unit, notice: 'Workout unit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @workout_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workout_units/1
  # DELETE /workout_units/1.json
  def destroy
    if @workout_unit.user_id = current_user.id
      @workout_unit.destroy
      respond_to do |format|
        format.html { redirect_to workout_units_url }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout_unit
      @workout_unit = WorkoutUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workout_unit_params
      params.require(:workout_unit).permit(:date, :workout_unit_type_id)
    end
end
