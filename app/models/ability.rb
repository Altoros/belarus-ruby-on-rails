class Ability
  include CanCan::Ability

  def initialize(user)
    unless user
      can :read, CustomNews
      can :read, Comment
    else
      # admin
      can :manage, :all if user.is_admin?

      # user
      can :read, CustomNews

      can :read, Profile
      can :update, Profile do |profile|
        profile.try(:user) == user || user.is_admin?
      end

      can :read, Comment
      can :create, Comment
      can :manage, Comment do |comment|
        comment.try(:user) == user
      end
    end
  end
end
