require 'rails_helper'

describe MessageRequest do
  # pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: message_requests
#
#  id                  :bigint           not null, primary key
#  sender_id           :bigint
#  receiver_id         :bigint
#  message_template_id :bigint
#  sent_at             :datetime
#  body                :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
