class UserMeasurementsController < ApplicationController
  before_action :set_user_measurement, only: [:show, :edit, :update, :destroy]

  # GET /user_measurements
  # GET /user_measurements.json
  def index
    @user_measurements = current_user.measurements.joins(:measurement)
    @measurement_set = {}
    @user_measurements.each do |um|
      a = @measurement_set[um.measurement.name] || []
      a.push ({unix_date: um.date.to_i, value: um.value})
      @measurement_set[um.measurement.name]=a
    end
    #render :text => CGI.escapeHTML(measurement_set.to_s)
    #return
  end

  # GET /user_measurements/1
  # GET /user_measurements/1.json
  def show
  end

  # GET /user_measurements/new
  def new
    @user_measurement = UserMeasurement.new
  end

  # GET /user_measurements/1/edit
  def edit
  end

  # POST /user_measurements
  # POST /user_measurements.json
  def create
    @user_measurement = UserMeasurement.new(user_measurement_params)
    @user_measurement.user_id = current_user.id

    respond_to do |format|
      if @user_measurement.save
        format.html { redirect_to @user_measurement, notice: 'User measurement was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_measurement }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_measurement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_measurements/1
  # PATCH/PUT /user_measurements/1.json
  def update
    respond_to do |format|
      if @user_measurement.update(user_measurement_params)
        format.html { redirect_to @user_measurement, notice: 'User measurement was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_measurement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_measurements/1
  # DELETE /user_measurements/1.json
  def destroy
    @user_measurement.destroy
    respond_to do |format|
      format.html { redirect_to user_measurements_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_measurement
      @user_measurement = UserMeasurement.find(params[:id])
      @measurements = Measurement.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_measurement_params
      params.require(:user_measurement).permit(:user_id, :measurement_id, :value, :value_string, :note, :date, :unix_date)
    end
end
