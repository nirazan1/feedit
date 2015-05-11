class Comment < ActiveRecord::Base

  belongs_to :feed
  belongs_to :user
  # validates :body, presence: true,length: { within: 1..140 }

  
end
