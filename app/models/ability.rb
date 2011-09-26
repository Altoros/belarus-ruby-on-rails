class Ability
  include CanCan::Ability

  def initialize(user)
    unless user
      can :read, CustomNews
    else
      # admin
      can :manage, :all if user.is_admin?

      # user
      can :read, CustomNews

      can :read, Profile
      can :update, Profile do |profile|
        profile.try(:user) == user || user.is_admin?
      end
    end
  end
end
