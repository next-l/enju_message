class MessagePolicy < AdminPolicy
  def index?
    user.try(:has_role?, 'User')
  end

  def create?
    user.try(:has_role?, 'User')
  end
end
