FactoryBot.define do
  factory :message do
    recipient{FactoryBot.create(:user).username}
    sender{FactoryBot.create(:user)}
    subject { 'new message' }
    body { 'new message body is really short' }
    association :message_request
  end
end
