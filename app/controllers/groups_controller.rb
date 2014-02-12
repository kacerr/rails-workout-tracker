class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
  	# we can destroy group only if current user is owner or current user is admin
  	if @group.owner_id = current_user.id || is_admin?(current_user)
	    @group.destroy
	    respond_to do |format|
	      format.html { redirect_back_or mygroups_path }
	      format.json { head :no_content }
	    end
	   end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end
end