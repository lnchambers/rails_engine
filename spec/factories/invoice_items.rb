FactoryBot.define do
  factory :invoice_item do
    item
    invoice
    unit_price 5999
    quantity 10
  end
end
