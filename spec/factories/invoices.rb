FactoryBot.define do
  factory :invoice do
    customer
    merchant
    status "It's Complicated"
  end
end
