class WorkoutsController < ApplicationController
  before_action :set_workout, only: [:show, :show_details, :edit, :update, :destroy]

  # GET /workouts
  # GET /workouts.json
  def index
    # if user is not admin then we want to get just hist workouts
    if is_admin?
      if own_only?
        @workouts = current_user.workouts.all
      else
        @workouts = Workout.all
      end
    else
      @workouts = current_user.workouts.all
    end
  end

  # GET /workouts/1
  # GET /workouts/1.json
  def show
    @allowModify = true
  end

  # GET /workout-details/1
  def show_details
    @allowModify = false
    render :show
  end

  # GET /workouts/new
  def new
    @workout = Workout.new
    @workout.date = Time.now
  end

  # GET /workouts/1/edit
  def edit
  end

  # POST /workouts
  # POST /workouts.json
  def create
    @workout = Workout.new(workout_params)

    respond_to do |format|
      if @workout.save
        format.html { redirect_to @workout, notice: 'Workout was successfully created.' }
        format.json { render action: 'show', status: :created, location: @workout }
      else
        format.html { render action: 'new' }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workouts/1
  # PATCH/PUT /workouts/1.json
  def update
    respond_to do |format|
      if @workout.update(workout_params)
        format.html { redirect_to @workout, notice: 'Workout was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @workout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workouts/1
  # DELETE /workouts/1.json
  def destroy
    @workout.destroy
    respond_to do |format|
      format.html { redirect_to workouts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout
      @workout = Workout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workout_params
      params.require(:workout).permit(:title, :content, :user_id, :date)
    end
end
