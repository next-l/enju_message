class MessagePolicy < AdminPolicy
  def index?
    user.try(:has_role?, 'User')
  end

  def show?
    if user
      true if user == record.receiver 
    end
  end

  def new?
    if user
      case user.role.name
      when 'User'
        true if record.receiver.try(:has_role?, 'Librarian') and record.sender == user
      when 'Librarian'
        true
      when 'Administrator'
        true
      end
    end
  end

  def create?
    if user
      case user.role.name
      when 'User'
        true if record.receiver.try(:has_role?, 'Librarian')
      when 'Librarian'
        true
      when 'Administrator'
        true
      end
    end
  end

  def destroy?
    if user
      case user.role.name
      when 'User'
        true if record.receiver == user
      when 'Librarian'
        true if record.receiver == user
      when 'Administrator'
        true
      end
    end
  end
end
