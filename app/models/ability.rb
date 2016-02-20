class Ability
  include CanCan::Ability

  def initialize( user )
    user ||= User.new

    # Define User abilities
    if user.role == "admin"
      can :manage, :all
    elsif user.role == "accounting"
      can :read, :all
      can :manage, Task
      can :manage, Product
      can :manage, Po
      can [:read, :edit, :mamage, :update, :destroy], Notification
    elsif user.role == "user2"
      can :read, :all
      can :manage, Task
      can :manage, Instruction
      can :manage, Po
      can :manage, Cost
      can [:read, :edit, :mamage, :update, :destroy], Notification
    elsif user.role == "user"
      can :read, :all
      can :manage, Task
      can :manage, Instruction
      can [:read, :edit, :mamage, :update, :destroy], Notification
    elsif user.role == "factory"
      can :manage, Sample
      can :manage, Task
      can :manage, Instruction
      can [:read], Project
      can [:read], Product
      can [:read], Po
      can [:read], Report
      can [:read], Patent
      can [:read, :edit, :mamage, :update, :destroy], Notification
    elsif user.role == "designer"
      can :manage, Task
      can [:read], Project
      can [:read], Product
      can [:read], Sample
      can [:read], Patent
      can [:read, :edit, :mamage, :update, :destroy], Notification
    else
      cannot [:mamage, :read], :all
    end
  end
end
