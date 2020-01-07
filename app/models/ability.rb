# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Event, public: true

    if user.present? # Logged in
      can :read, User

      if user.chair? # Chair or Eboard
        can :manage, Event

        if user.eboard?
          can :manage, :all
        end
      end
    end
  end
end
