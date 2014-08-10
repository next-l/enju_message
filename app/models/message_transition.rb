class MessageTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  
  belongs_to :message, inverse_of: :message_transitions
  attr_accessible :to_state, :sort_key, :metadata
end

# == Schema Information
#
# Table name: message_transitions
#
#  id         :integer          not null, primary key
#  to_state   :string(255)
#  metadata   :text             default("{}")
#  sort_key   :integer
#  message_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
