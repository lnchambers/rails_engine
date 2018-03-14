require "rails_helper"

describe "Transaction Invoice Request" do
  it "can return all invoices related to the transaction" do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice: invoice)
    create(:invoice, status: "pending")

    get "/api/v1/transactions/#{transaction.id}/invoice"

    invoice_response = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_response["status"]).to eq(invoice.status)
  end
end
