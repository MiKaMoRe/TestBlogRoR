# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    @user = user

    return guest_abilities if not user.persisted?
    user_abilities
  end

  def guest_abilities
    can :read, [Post]
  end

  def user_abilities
    guest_abilities

    can :manage, [Post], author_id: user.id
  end
end
