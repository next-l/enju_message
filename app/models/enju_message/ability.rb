module EnjuMessage
  class Ability
    include CanCan::Ability
      
    def initialize(user, ip_address = nil)
      case user.try(:role).try(:name)
      when 'Administrator'
        can :manage, Message
        can [:read, :update, :destroy, :delete], MessageRequest
        can [:read, :update], MessageTemplate
      when 'Librarian'
        can [:index, :create], Message
        can [:update], Message do |message|
          message.sender == user
        end
        can [:show, :destroy, :delete], Message do |message|
          message.receiver == user
        end
        can [:read, :update, :destroy, :delete], MessageRequest
        can :read, MessageTemplate
      when 'User'
        can [:read, :destroy, :delete], Message do |message|
          message.receiver == user
        end
        can :index, Message
        can :show, Message do |message|
          message.receiver == user
        end
      end
    end
  end
end
