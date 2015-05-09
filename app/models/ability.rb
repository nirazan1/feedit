class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    can :access, :rails_admin   # grant access to rails_admin
    can :dashboard              # grant access to the dashboard
    can :create , Feed
    can :update , Feed do |feed|
        feed.user.try(:username) == user.username
    end
    can :destroy, Feed do |feed|
        feed.user.try(:username) == user.username
    end
    can :destroy, Comment do |c|
        c.user.try(:username) == user.username
    end
    can :upvote, Feed
    can :downvote, Feed
  end
end
