class MessageRequestTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition
  
  belongs_to :message_request, inverse_of: :message_request_transitions
  # attr_accessible :to_state, :sort_key, :metadata
end

# == Schema Information
#
# Table name: message_request_transitions
#
#  id                 :integer          not null, primary key
#  to_state           :string
#  metadata           :text             default({})
#  sort_key           :integer
#  message_request_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#  most_recent        :boolean          not null
#
