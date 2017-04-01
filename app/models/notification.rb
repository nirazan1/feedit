class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :feed
  belongs_to :comment
  belongs_to :conversation


  def set_read
    self.read = true
  end

  def self.set_conversation_notification(recipient_id, sender_id, conversation)
    new_notification = Notification.create(read: false , user_id: recipient_id, sender_id: sender_id,conversation_id: conversation)
    new_notification.save
  end

  def sender
    User.find(self.sender_id)
  end

end
