class AddSenderIdToNotification < ActiveRecord::Migration
  def change
    add_reference :notifications, :sender, index: true, foreign_key: true
  end
end
