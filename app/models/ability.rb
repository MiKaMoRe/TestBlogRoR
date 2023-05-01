# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    guest_abilities if not user.persisted?
  end

  def guest_abilities
    can :read, [Post]
  end
end
