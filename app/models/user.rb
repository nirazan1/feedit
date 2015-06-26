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
  validates :avatar, presence: true

  has_many :feeds, dependent: :destroy
  has_many :comments, dependent: :destroy
  acts_as_voter

end
