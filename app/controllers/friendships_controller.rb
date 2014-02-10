class FriendshipsController < ApplicationController

  # GET /rejectfriendship/7/10
  def reject
    friendship = Friendship.where(to_user_id: params[:to_id], from_user_id: params[:from_id]).first
    if !friendship
      flash[:error] = 'There was no such a friendship request '
      redirect_back_or root_path
    else
      # we are going to send rejection message
      message =  Message.new(from_user_id: params[:to_id], to_user_id: params[:from_id], message_type: "friendship-rejection", status: "new")
      message.text = "User #{User.find(params[:to_id]).email} does not seem to want to be friends with you, sorry."
      message.save
      # we are going to delete friendship request
      friendship.destroy
      # and we also need to delete message containing friend request
      messageToDelete = Message.where(to_user_id: params[:to_id], from_user_id: params[:from_id], message_type: "friend-request", status: "pending").first
      messageToDelete.destroy if messageToDelete
      flash[:notice] = 'Friendship request was rejected'
      redirect_back_or root_path
    end
  end

  # GET /acceptfriendship/7/10
  def accept
    friendship = Friendship.where(to_user_id: params[:to_id], from_user_id: params[:from_id]).first
    if !friendship
      flash[:error] = 'There was no such a friendship request '
      redirect_back_or root_path
    else
      # we are going to send acceptation message
      message =  Message.new(from_user_id: params[:to_id], to_user_id: params[:from_id], message_type: "friendship-acceptation", status: "new")
      message.text = "User #{User.find(params[:to_id]).email} agreed. Now you are friends :-)"
      message.save
      # we are going to delete friendship request
      friendship.type="both-ways-confirmed"
      friendship.save
      # and we also need to delete message containing friend request
      messageToDelete = Message.where(to_user_id: params[:to_id], from_user_id: params[:from_id], message_type: "friend-request", status: "pending").first
      messageToDelete.destroy if messageToDelete
      flash[:notice] = 'Friendship request accepted'
      redirect_back_or root_path
    end
  end

end