# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
  
    user ||= User.new

    can [:update, :read], Note, user_id: user.id

    if user.persisted?

      can :create, Note

      can :read, Note do |note|
        note.readers.include?(user)  
      end
    end

  end
end
