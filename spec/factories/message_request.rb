FactoryBot.define do
  factory :message_request do
    sender_id{FactoryBot.create(:user).id}
    receiver_id{FactoryBot.create(:user).id}
    message_template_id{FactoryBot.create(:message_template).id}
    body { 'test' }
  end
end
