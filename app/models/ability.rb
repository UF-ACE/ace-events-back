# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Event, public: true
    can :upcoming, Event, public: true
    can :read, Attendee, public: true

    if user.present? # Logged in
      can :read, User
      can :create, Attendee, user_id: user.id
      can :destroy, Attendee, user_id: user.id

      if user.chair? # Chair or Eboard
        can :manage, Event
        can :manage, Attendee

        if user.eboard?
          can :manage, :all
        end
      end
    end
  end
end
