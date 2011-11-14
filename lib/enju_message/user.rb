module EnjuMessage
  module User
    def send_message(status, options = {})
      MessageRequest.transaction do
        request = MessageRequest.new
        request.sender = User.find(1)
        request.receiver = self
        request.message_template = MessageTemplate.localized_template(status, self.locale)
        request.save_message_body(options)
        request.sm_send_message!
      end
    end
  end
end

class User < ActiveRecord::Base
  include EnjuMessage::User

  has_many :sent_messages, :foreign_key => 'sender_id', :class_name => 'Message'
  has_many :received_messages, :foreign_key => 'receiver_id', :class_name => 'Message'
end
