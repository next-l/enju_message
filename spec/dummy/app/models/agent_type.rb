class AgentType < ActiveRecord::Base
  include MasterModel
  default_scope :order => "agent_types.position"
  has_many :agents
end

# == Schema Information
#
# Table name: agent_types
#
#  id           :integer         not null, primary key
#  name         :string(255)     not null
#  display_name :text
#  note         :text
#  position     :integer
#  created_at   :datetime
#  updated_at   :datetime
#

