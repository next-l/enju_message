class MessageRequestStateMachine
  include Statesman::Machine

  state :pending, initial: true
  state :sent

  transition from: :pending, to: :sent

  before_transition(from: :pending, to: :sent) do |message_request|
  end
end
