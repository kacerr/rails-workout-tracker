class MessagesController < ApplicationController

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

end