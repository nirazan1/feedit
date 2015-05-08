class Feed < ActiveRecord::Base
	has_many :comments, dependent: :destroy
	validates :name, presence: true,
                    length: { minimum: 5 }
  validates :text, presence: true
  belongs_to :user
  acts_as_votable

end