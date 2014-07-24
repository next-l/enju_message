class Ability
  def initialize_message(user, ip_address = nil)
    case user.try(:role).try(:name)
    when 'Administrator'
      can :manage, Message
      can [:read, :update, :destroy], MessageRequest
      can [:read, :update], MessageTemplate
    when 'Librarian'
      can [:index, :create], Message
      can [:update], Message do |message|
        message.sender == user
      end 
      can [:show, :destroy, :destroy_selected], Message do |message|
        message.receiver == user
      end 
      can [:read, :update, :destroy], MessageRequest
      can :read, MessageTemplate
    when 'User'
      can [:read, :destroy, :destroy_selected], Message do |message|
        message.receiver == user
      end 
      can [:index, :create], Message
      can :show, Message do |message|
      end 
    end 
  end
end
