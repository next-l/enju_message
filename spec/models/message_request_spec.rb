require 'rails_helper'

describe MessageRequest do
  # pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: message_requests
#
#  id                  :integer          not null, primary key
#  sender_id           :bigint
#  receiver_id         :integer
#  message_template_id :integer
#  sent_at             :datetime
#  deleted_at          :datetime
#  body                :text
#  created_at          :datetime
#  updated_at          :datetime
#
