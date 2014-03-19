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

  def summary
    # we need list of users that are going to be displayed (=they have something logged in)
    users = User.where(id: WorkoutUnit.uniq.pluck(:user_id))
    @users_hash = {}
    users.each do |u|
      @users_hash[u.id] = u.attributes
    end

    # we also need sum of point they get
    query = "select user_id, sum(difficulty) from workout_units wu
      left join workout_unit_types wut on wut.id = wu.workout_unit_type_id
      group by user_id"
    results = ActiveRecord::Base.connection.execute(query)
    results.each do |r|
      @users_hash[r[0]]["total"]=r[1]
    end

    # and we need to have all recorder workout units stored in the hash[:user_id][:date][]
    wus = WorkoutUnit.joins(:workout_unit_type).load
    @wus_hash = {}
    wus.each do |wu|
      @wus_hash[wu.user_id] ||= {}
      @wus_hash[wu.user_id][wu.date.strftime('%Y-%m-%d')] ||= []
      @wus_hash[wu.user_id][wu.date.strftime('%Y-%m-%d')] << wu
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
