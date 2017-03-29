module MessagesHelper
  def self_or_other(message)
    message.user == current_user ? "self" : "other"
  end

  def message_interlocutor(message)
    message.user == message.conversation.sender ? message.conversation.sender : message.conversation.recipient
  end

  def day_in_words_or_date(datetime)
    return 'n/a' if datetime.blank?
    if datetime.today?
      datetime.strftime('%H:%M %p')
    elsif datetime.to_date == Date.yesterday
      'Yesterday @ ' + datetime.strftime('%H:%M %p')
    else
      datetime.strftime('%l:%M %p, %b %e (%a)')
    end
  end
end
