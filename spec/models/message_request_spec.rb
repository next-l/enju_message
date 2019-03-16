require 'rails_helper'

describe MessageRequest do
  # pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: message_requests
#
#  id                  :uuid             not null, primary key
#  sender_id           :bigint(8)
#  receiver_id         :bigint(8)
#  message_template_id :bigint(8)
#  sent_at             :datetime
#  body                :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
