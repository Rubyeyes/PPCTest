class Ability
  include CanCan::Ability

  def initialize( user )
    user ||= User.new

    # Define User abilities
    if user.role == "admin"
      can :manage, :all
    elsif user.role == "user"
      can :read, :all
    else
      can [:create, :edit, :read], Sample
      can [:create, :edit, :read], Cost
      can [:read], Project
      can [:read, :edit], Product
    end
  end
end
