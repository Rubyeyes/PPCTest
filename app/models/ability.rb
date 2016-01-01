class Ability
  include CanCan::Ability

  def initialize( user )
    user ||= User.new

    # Define User abilities
    if user.is? :admin
      can :manage, Project
    else
      can :read, Project
    end
  end
end
