FactoryBot.define do
  factory :message do |f|
    f.recipient{FactoryBot.create(:profile).user.username}
    f.sender{FactoryBot.create(:profile).user}
    f.subject 'new message'
    f.body 'new message body is really short'
  end
end
