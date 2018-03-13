FactoryBot.define do
  factory :transaction do
    invoice
    credit_card_number 4654405418249632
    credit_card_expiration_date nil
    result "success"
  end
end
