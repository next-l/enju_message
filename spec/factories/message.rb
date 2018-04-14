FactoryBot.define do
  factory :message do |f|
    f.recipient{FactoryBot.create(:user).username}
    f.sender{FactoryBot.create(:user)}
    f.message_request{FactoryBot.create(:message_request)}
    f.subject 'new message'
    f.body 'new message body is really short'
  end
end
