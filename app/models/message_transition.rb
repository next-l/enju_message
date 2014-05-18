class MessageTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  
  belongs_to :message, inverse_of: :message_transitions
end
