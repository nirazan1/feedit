class User < ActiveRecord::Base
	mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  validates :first_name, presence: true,
                    length: { minimum: 2 }
  validates :username, presence: true,
                    length: { minimum: 2 }, uniqueness: { case_sensitive: false }
  # validates :avatar, presence: true
  # validates :time_zone, presence: true

  has_many :feeds, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_many :messages, dependent: :destroy
  acts_as_voter

  def clear_conversation_notifications(conversation_id)
    notifications.where(conversation_id: conversation_id).each do |n|
      n.update_attributes(read: true)
    end
  end

  def new_notification
    notifications.where(read: false).count
  end

end
