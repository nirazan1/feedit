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
      datetime.strftime('%l:%M %p') + ' Today'
    elsif datetime.to_date == Date.yesterday
      datetime.strftime('%l:%M %p') + ' Yesterday'
    else
      datetime.strftime('%l:%M %p, %b %e (%a) %Y')
      #  4:18 PM, Jan 10 (Tue) 2017
    end
  end
end
