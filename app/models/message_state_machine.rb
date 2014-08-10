class MessageStateMachine
  include Statesman::Machine

  state :unread, initial: true
  state :read

  transition from: :unread, to: :read
  transition from: :read, to: :unread

  before_transition(from: :unread, to: :read) do |message|
    message.read_at = Time.zone.now unless message.read_at
  end

  before_transition(from: :read, to: :unread) do |message|
    message.read_at = nil
  end
end
