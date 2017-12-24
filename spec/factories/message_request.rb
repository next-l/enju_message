FactoryBot.define do
  factory :message_request do |f|
    f.sender_id{FactoryBot.create(:user).id}
    f.receiver_id{FactoryBot.create(:user).id}
    f.message_template_id{FactoryBot.create(:message_template).id}
    f.body 'test'
  end
end
