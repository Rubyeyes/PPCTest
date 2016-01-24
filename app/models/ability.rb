class Ability
  include CanCan::Ability

  def initialize( user )
    user ||= User.new

    # Define User abilities
    if user.role == "admin"
      can :manage, :all
    elsif user.role == "user"
      can :read, :all
    elsif user.role == "factory"
      can :manage, Sample
      can :manage, Cost
      can [:read], Project
      can [:read], Product
    else
      cannot [:mamage, :read], :all
    end
  end
end
