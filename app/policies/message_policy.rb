class MessagePolicy < AdminPolicy
  def index?
    user.try(:has_role?, 'User')
  end

  def show?
    if user
      true if user == record.receiver 
    end
  end

  def create?
    user.try(:has_role?, 'User')
  end

  def destroy?
    user.try(:has_role?, 'Librarian')
  end
end
