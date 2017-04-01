class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user

  validates_presence_of :body, :conversation_id, :user_id


  def update_chatbox(params)
    Pusher.url = "https://1b870432c3653d665c75:e032c81d286eba5a448d@api.pusherapp.com/apps/181805"

    Pusher.trigger('private-'+ conversation.id.to_s, 'my_event', {
        message: body,
        username: message_interlocutor.username,
        dt: day_in_word_or_date(created_at),
        sender_id: user.id,
        sender: user.username,
        conversation_id: conversation.id,
        mcdt: day_in_word_or_date(created_at),
        avatar: message_interlocutor.avatar.url(:thumbnail)
     },
     {
       socket_id: params[:socket_id]
     })

  end

  def update_notification(params)
    Pusher.url = "https://1b870432c3653d665c75:e032c81d286eba5a448d@api.pusherapp.com/apps/181805"

    Pusher.trigger('private-notification'+message_recipient.id.to_s, 'my_notification', {
        message: body,
        sender_id: user.id,
        sender: user.username,
        conversation_id: conversation.id
     },
     {
       socket_id: params[:socket_id]
     })
  end

  def message_interlocutor
    user == conversation.sender ? conversation.sender : conversation.recipient
  end

  def day_in_word_or_date(datetime)
    return 'n/a' if datetime.blank?
    if datetime.today?
      datetime.strftime('%l:%M %p') + ' Today'
    elsif datetime.to_date == Date.yesterday
      datetime.strftime('%l:%M %p') + ' Yesterday'
    else
      datetime.strftime('%l:%M %p, %b %e (%a) %Y')
      #  4:18 PM, Jan 10 (Tue) 2017
    end
  end

  def message_recipient
    user == conversation.sender ? conversation.recipient : conversation.sender
  end

end
