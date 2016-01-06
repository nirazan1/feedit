class MessagesController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, only: [:create]


  def create
    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    @path = conversation_path(@conversation)
    respond_to do |format|
      if @message.save
        format.js
      end
    end
  end


  private

  def message_params
    params.require(:message).permit(:body)
  end
end
