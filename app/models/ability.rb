class Ability
  include CanCan::Ability

  def initialize(user)
    unless user
      can :read, Article
      can :read, Comment
    else
      # admin
      can :manage, :all if user.is_admin?

      # user
      can :read, Article

      can :read, Profile
      can :update, Profile do |profile|
        profile.try(:user) == user || user.is_admin?
      end

      can :read, Comment
      can :create, Comment
      can :manage, Comment do |comment|
        comment and comment.user == user
      end
    end
  end
end
