class Ability
  include CanCan::Ability

  def initialize( user )
    user ||= User.new

    # Define User abilities
    if user.role == "admin"
      can :manage, :all
    elsif user.role == "user"
      can :read, :all
      can :manage, Po
    elsif user.role == "factory"
      can :manage, Sample
      can :manage, Cost
      can [:read], Project
      can [:read], Product
      can [:read, :edit, :mamage, :update], Notification
      can [:read], Po
      can [:read], Report
    else
      cannot [:mamage, :read], :all
    end
  end
end
