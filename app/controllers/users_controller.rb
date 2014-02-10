class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        UserMailer.registration_confirmation(@user).deliver
        format.html { 
          sign_in @user
          flash[:notice] = "Welcome to the Workout tracker baby!"
          redirect_to welcome_path
          # redirect_to @user, notice: 'User was successfully created.' 
        }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  # Sends a friend request to target user
  def befriend
    # send a friend request only if there is not one already pending
    friendship = Friendship.where(to_user_id: params[:id], from_user_id: current_user.id).first
    if friendship && friendship.type=="both-ways-unconfirmed"
      # do nothing or display warning?
      flash[:error] = 'There is already pending friend request from you to ' + User.find(params[:id]).email
      # over here i would like to redirect to page where we came from
      redirect_to :back
    else
      # first get information about current friendship status
      friendship = Friendship.where(to_user_id: params[:id], from_user_id: current_user.id).first
      if friendship && friendship.type=="both-ways-confirmed"
        # friendship is already established just give user notice about that
        redirect_to :back, warning: "Friendship with #{User.find(params[:id]).email} is already established"
      else
        # create friend request
        friend_request =  Message.new(from_user_id: current_user.id, to_user_id: params[:id], message_type: "friend-request", status: "pending")
        friend_request.save
        if friendship
          friendship.type = "both-ways-unconfirmed"
        else
          friendship = Friendship.new(from_user_id: current_user.id, to_user_id: params[:id], type: "both-ways-unconfirmed")
        end
        friendship.save
      end
      redirect_to :back, notice: "Friend request to #{User.find(params[:id]).email} was sent"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
    end
end
