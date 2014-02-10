class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /inbox/in
  # GET /inbox/ou
  def index
    if params[:part] == "in"
      @inbox = true
      @inbox_title = "Received messages"
      @messages = current_user.received_messages
    else
      @inbox = false
      @inbox_title = "Sent messages"
      @messages = current_user.sent_messages
    end 
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_back_or messages_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:title, :content, :user_id, :date)
    end

end