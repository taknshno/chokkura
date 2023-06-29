FactoryBot.define do
  factory :tagging do
    association :spot
    association :tag
  end
end
