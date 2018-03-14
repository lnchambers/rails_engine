require "rails_helper"

describe "Invoice Transaction Request" do
  it "can return all transactions under a specific invoice" do
    invoice = create(:invoice)
    transaction = create_list(:transaction, 3, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/transactions"

    transactions = JSON.parse(response.body)

    expect(response).to be_success
    expect(transactions.count).to eq(3)
    expect(response.body).to match(transactions.to_json)
  end
end
