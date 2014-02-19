class ExcercisesController < ApplicationController
  before_action :set_excercise, only: [:show, :edit, :update, :destroy]

  # GET /excercises
  # GET /excercises.json
  def index
    @excercises = Excercise.all
  end

  # GET /excercises/1
  # GET /excercises/1.json
  def show
  end

  # GET /excercises/new
  def new
    @excercise = Excercise.new
  end

  # GET /excercises/1/edit
  def edit
  end

  # POST /excercises
  # POST /excercises.json
  def create
    @excercise = Excercise.new(excercise_params)
    @excercise.user_id = current_user.id

    respond_to do |format|
      if @excercise.save
        format.html { redirect_to @excercise, notice: 'Excercise was successfully created.' }
        format.json { render action: 'show', status: :created, location: @excercise }
      else
        format.html { render action: 'new' }
        format.json { render json: @excercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /excercises/1
  # PATCH/PUT /excercises/1.json
  def update
    respond_to do |format|
      if @excercise.update(excercise_params)
        format.html { redirect_to @excercise, notice: 'Excercise was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @excercise.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /excercises/1
  # DELETE /excercises/1.json
  def destroy
    @excercise.destroy
    respond_to do |format|
      format.html { redirect_to excercises_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_excercise
      @excercise = Excercise.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def excercise_params
      params.require(:excercise).permit(:name, :description, :url, :video_url)
    end
end
