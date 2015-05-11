class Feed < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	
  validates :text, presence: true,length: { within: 1..200 }
  belongs_to :user
  acts_as_votable

end
