require 'rails_helper'

describe Message do
  fixtures :all

  before(:each) do
    @message = FactoryGirl.create(:message)
  end

  it 'should require body' do
    @message.errors[:body].should be_truthy
  end

  it 'should require recipient' do
    @message.errors[:recipient].should be_truthy
  end

  it 'should require subject' do
    @message.errors[:subject].should be_truthy
  end

  it 'should return sender_name' do
    @message.sender.username.should be_truthy
  end

  it 'should return receiver_name' do
    @message.receiver = users(:user1)
    @message.receiver.username.should be_truthy
  end

  it 'should set read_at' do
    message = messages(:user2_to_user1_1)
    message.transition_to!(:read)
    message.read_at.should be_truthy
    message.read?.should be_truthy
    message.current_state.should eq 'read'
  end

  it 'should require valid recipient' do
    @message.recipient = 'invalidusername'
    @message.save.should be_falsy
  end
end

# == Schema Information
#
# Table name: messages
#
#  id                 :uuid             not null, primary key
#  read_at            :datetime
#  receiver_id        :integer
#  sender_id          :integer
#  subject            :string           not null
#  body               :text
#  message_request_id :integer
#  parent_id          :uuid
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  lft                :integer
#  rgt                :integer
#  depth              :integer
#
