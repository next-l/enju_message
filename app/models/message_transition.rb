class MessageTransition < ActiveRecord::Base
  include Statesman::Adapters::ActiveRecordTransition

  
  belongs_to :message, inverse_of: :message_transitions
  #attr_accessible :to_state, :sort_key, :metadata
end

# == Schema Information
#
# Table name: message_transitions
#
#  id          :integer          not null, primary key
#  to_state    :string
#  metadata    :text             default({})
#  sort_key    :integer
#  message_id  :integer
#  created_at  :datetime
#  updated_at  :datetime
#  most_recent :boolean          not null
#
