FactoryBot.define do
  factory :skill do
    account { nil }
    skill { "MyString" }
    routing_weight { 1 }
    threshold { 1 }
    self_administered { false }
  end
end
