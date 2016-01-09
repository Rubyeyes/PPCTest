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
      can :create, Sample, Cost
      can :edit, Sample, Cost
    end
  end
end
