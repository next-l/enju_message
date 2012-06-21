module EnjuMessage
  module MessageUser
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def enju_message_user
        include InstanceMethods
        has_many :sent_messages, :foreign_key => 'sender_id', :class_name => 'Message'
        has_many :received_messages, :foreign_key => 'receiver_id', :class_name => 'Message'
      end
    end

    module InstanceMethods
      def send_message(status, options = {})
        MessageRequest.transaction do
          request = MessageRequest.new
          request.sender = self.class.find(1)
          request.receiver = self
          request.message_template = MessageTemplate.localized_template(status, self.locale)
          request.save_message_body(options)
          request.sm_send_message!
        end
      end
    end
  end
end
