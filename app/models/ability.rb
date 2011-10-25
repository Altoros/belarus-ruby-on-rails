class Ability
  include CanCan::Ability

  def initialize(user)
    unless user
      can :read, Article do |article|
        article.published?
      end
      can :read, Comment
    else
      # admin
      can :manage, :all if user.is_admin?
      can :admin, :dashboard if user.is_admin?

      # user
      can :read, Article do |article|
        article.published?
      end

      can :read, Profile
      can :update, Profile do |profile|
        profile.try(:user) == user || user.is_admin?
      end

      can :read, Comment
      can :create, Comment unless user.banned?
      can :manage, Comment do |comment|
        comment and comment.user == user and not user.banned?
      end
    end
  end
end
