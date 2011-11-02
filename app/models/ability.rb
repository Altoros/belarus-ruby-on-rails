class Ability
  include CanCan::Ability

  def initialize(user)
    unless user
      can :read, Article do |article|
        article.published?
      end
      can :read, Comment
      can :read, StaticPage
    else
      # admin
      can :manage, :all if user.is_admin?
      can :admin, :dashboard if user.is_admin?
      can :manage, StaticPage if user.is_admin?
      can :reset_password, User if user.is_admin?

      # user
      can :read, Article do |article|
        article.published?
      end


      can :read, Profile
      can [:update, :delete_avatar], Profile do |profile|
        profile.try(:user) == user || user.is_admin?
      end

      can :read, Comment
      can :create, Comment unless user.banned?
      can :manage, Comment do |comment|
        comment and comment.user == user and not user.banned?
      end

      can :read, StaticPage
    end
  end
end
