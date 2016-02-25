class MessagesController < ApplicationController
  before_filter :authenticate_user!
  skip_before_filter :verify_authenticity_token, only: [:create]


  def create

    Pusher.app_id = PUSHER_APP_ID
    Pusher.key = PUSHER_KEY
    Pusher.secret = PUSHER_SECRET


    @conversation = Conversation.find(params[:conversation_id])
    @message = @conversation.messages.build(message_params)
    @message.user_id = current_user.id
    @path = conversation_path(@conversation)

    @notification_recipient_id = current_user.id == @message.conversation.sender_id ? @message.conversation.recipient_id : @message.conversation.sender_id
    Notification.set_conversation_notification(@notification_recipient_id, current_user.id, @conversation.id)

    if @message.save
      Pusher.url = "https://1b870432c3653d665c75:e032c81d286eba5a448d@api.pusherapp.com/apps/181805"

      Pusher.trigger(@conversation.id.to_s, 'my_event', {
          message: @message.body,
          username: message_interlocutor(@message).username,
          dt: @message.created_at.strftime("%H:%M %p"),
          sender_id: @message.user.id,
          mcdt: @message.created_at
       },
       {
         socket_id: params[:socket_id]
       })
      respond_to :js
    else
      format.html { redirect_to @conversation, notice: 'Failed ! Retry ' }
    end

  end

  def self_or_other(message)
    message.user == current_user ? "self" : "other"
  end

  def message_interlocutor(message)
    message.user == message.conversation.sender ? message.conversation.sender : message.conversation.recipient
  end


  private

  def message_params
    params.require(:message).permit(:body)
  end
end
