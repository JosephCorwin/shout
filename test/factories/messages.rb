FactoryBot.define do
  factory :message do
    user { nil }
    ttl { 1 }
    b_chain { "MyText" }
    b_type { 1 }
  end
end
