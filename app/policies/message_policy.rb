class MessagePolicy < ApplicationPolicy
  def index?
    true if user.try(:has_role?, 'User')
  end

  def show?
    case user.try(:role).try(:name)
    when 'Administrator'
      true
    when 'Librarian'
      true if record.receiver == user
    when 'User'
      true if record.receiver == user
    end
  end

  def create?
    true if user.try(:has_role?, 'Librarian')
  end

  def update?
    case user.try(:role).try(:name)
    when 'Administrator'
      true if record.receiver == user
    when 'Librarian'
      true if record.receiver == user
    end
  end

  def destroy?
    show?
  end
end
