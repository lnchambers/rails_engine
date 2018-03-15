require "rails_helper"

describe "Customer Transaction Request" do
  it "can return all transactions under a specific customer" do
    customer = create(:customer)
    invoice = create(:invoice, customer: customer)
    invoice_2 = create(:invoice)
    transaction = create(:transaction, invoice: invoice)
    create_list(:transaction, 4, invoice: invoice)
    create(:transaction, invoice: invoice_2)

    get "/api/v1/customers/#{customer.id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(5)
    expect(transactions[0]["credit_card_number"]).to eq(transaction.credit_card_number.to_s)
    expect(transactions[0]["result"]).to eq(transaction.result)
  end
end
