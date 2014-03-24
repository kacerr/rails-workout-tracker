class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :show_profile]
  skip_before_action :require_login, only: [:new, :create]
  
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
    if @user.profile
      @profile = @user.profile
    else
      @profile = Profile.new(user_id: @user.id)
      @profile.save
   end
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
    isUpdate = params[:action_details]=="update"
    if isUpdate
      #out = CGI.escapeHTML(@user.inspect)
      params[:user].each do |key, value|
        @user[key] = value
      end
      #out += CGI.escapeHTML(@user.inspect)
      #render :text  => out
      #return false
      updated = @user.save(:validate => false)
    else
      updated = @user.update(user_params)
    end
    respond_to do |format|
      if updated
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

  def show_profile
    render :profile
  end

  def groups_i_am_in
    @groups = Group.joins(memberships: :user).where('memberships.user_id' => current_user.id)
    @memberships_ids = current_user.memberships.where(:show_in_groups_stream => 1).pluck(:group_id)
    @group = Group.new
    @listing_only = true
    render :mygroups
  end

  def remove_me_from_group
    membership = Membership.where(user_id: current_user.id, group_id: params[:id]).first
    membership.destroy if membership
    redirect_back_or ""
  end

  def hide_group_from_stream
    membership = Membership.where(user_id: current_user.id, group_id: params[:id]).first
    membership.show_in_groups_stream = 0
    membership.save
    redirect_back_or ""
  end

  def show_group_in_stream
    membership = Membership.where(user_id: current_user.id, group_id: params[:id]).first
    membership.show_in_groups_stream = 1
    membership.save
    redirect_back_or ""
  end


  def mygroups
    @groups = current_user.groups
    @group = Group.new
    render :mygroups
  end

  def mygroups_save
    is_update = false
    if params[:commit]=="Create group"
      @group = Group.new(name: params[:name], description: params[:description], public: params[:public], owner_id: current_user.id)
    else
      @group = Group.find(params[:id])
      @group[:name]=params[:name]
      @group[:description]=params[:description]
      @group[:public]=params[:public]
      is_update = true
    end
    saved = @group.save
    @groups = current_user.groups

    #render :text => params.inspect
    #return

    respond_to do |format|
      if saved
        format.html { 
          if is_update 
            flash[:notice] = 'Group was successfully updated.'
          else
            flash[:notice] = 'New Group was successfully created.'
          end if
          redirect_back_or mygroups_path
        }
        format.json { render action: 'show', status: :created, location: @group }
      else
        format.html { render action: 'mygroups' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def mygroup_edit
    @group = Group.find(params[:id])
    @members = @group.users.all
    @nonmembers = User.all
    #render :text => CGI.escapeHTML(@members.inspect)
    #render :text => params
    render :mygroupdetail
  end

  def remove_user_from_group
    membership = Membership.where(user_id: params[:id], group_id: params[:group_id]).first
    membership.destroy if membership
    #render :text => params
    #redirect_to "/user/my-group-edit/#{params[:group_id]}"
    redirect_back_or "/user/my-group-edit/#{params[:group_id]}"
  end

  def add_me_to_group
    #render :text => "gonna add #{current_user.get_display_name}"
    membership = Membership.new(user_id: current_user.id, group_id: params[:group_id])
    membership.save
    flash[:notice] = "You were added to #{Group.find(membership.group_id).name} group"
    redirect_to root_path
  end


  def add_user_to_group
    membership = Membership.new(user_id: params[:id], group_id: params[:group_id])
    membership.save
    redirect_back_or "/user/my-group-edit/#{params[:group_id]}"
  end

  def set_default_group
    user = User.find(current_user.id)
    user.default_group_id = params[:group_id]
    user.save(:validate => false)
    redirect_back_or groups_i_am_in_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation, :display_name, :alternative_email, :visibility)
    end
end
