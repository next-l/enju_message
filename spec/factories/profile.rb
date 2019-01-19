FactoryBot.define do
  factory :profile, class: Profile do
    user_group_id {UserGroup.first.id}
    required_role_id {Role.where(name: 'User').first.id}
    sequence(:user_number){|n| "user_number_#{n}"}
    library_id { 2 }
    locale { 'ja' }
    after(:create) do |profile|
      user = FactoryBot.create(:user)
      profile.user = user
      profile.save
    end
  end
end
