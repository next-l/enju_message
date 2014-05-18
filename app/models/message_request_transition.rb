class MessageRequestTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  
  belongs_to :message_request, inverse_of: :message_request_transitions
end
