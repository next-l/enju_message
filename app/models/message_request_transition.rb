class MessageRequestTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  
  belongs_to :message_request, inverse_of: :message_request_transitions
end

# == Schema Information
#
# Table name: message_request_transitions
#
#  id                 :integer          not null, primary key
#  to_state           :string(255)
#  metadata           :text             default("{}")
#  sort_key           :integer
#  message_request_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
