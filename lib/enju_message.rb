require "enju_message/engine"
require "enju_message/user"

module EnjuMessage
end

ActiveRecord::Base.send :include, EnjuMessage::MessageUser
