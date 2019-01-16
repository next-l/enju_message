FactoryBot.define do
  factory :message do
    recipient{FactoryBot.create(:profile).user.username}
    sender{FactoryBot.create(:profile).user}
    subject { 'new message' }
    body { 'new message body is really short' }
    association :message_request
  end
end
