require 'rails_helper'

describe MessageRequest do
  fixtures :all

  before(:each) do
    @message_request = FactoryBot.create(:message_request)
  end

  it 'should send_message' do
    @message_request.send_message.should be_truthy
  end

end

# == Schema Information
#
# Table name: message_requests
#
#  id                  :integer          not null, primary key
#  sender_id           :integer
#  receiver_id         :integer
#  message_template_id :integer
#  sent_at             :datetime
#  body                :text
#  created_at          :datetime
#  updated_at          :datetime
#
