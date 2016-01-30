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
      can :manage, Task
    elsif user.role == "factory"
      can :manage, Sample
      can :manage, Cost
      can :manage, Task
      can [:read], Project
      can [:read], Product
      can [:read], Po
      can [:read], Report
      can [:read, :edit, :mamage, :update], Notification
    elsif user.role == "designer"
      can :manage, Task
      can [:read], Project
      can [:read], Product
      can [:read], Sample
      can [:read, :edit, :mamage, :update], Notification
    else
      cannot [:mamage, :read], :all
    end
  end
end
