class MessagesController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, only: [:create]


  def create

    Pusher.app_id = PUSHER_APP_ID
    Pusher.key = PUSHER_KEY
    Pusher.secret = PUSHER_SECRET


    conversation = Conversation.find(params[:conversation_id])
    message = conversation.messages.build(message_params)
    message.user_id = current_user.id
    path = conversation_path(conversation)

    notification = Notification.find_or_initialize_by(
       user_id: message.message_recipient.id,
       sender_id: current_user.id,
       conversation: conversation
      )
    notification.update_attributes!(read: false)

    if message.save
      message.update_chatbox(params)
      message.update_notification(params)
      respond_to :js
    else
      format.html { redirect_to conversation, notice: 'Failed ! Retry ' }
    end

  end

  def self_or_other(message)
    message.user == current_user ? "self" : "other"
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end
end
