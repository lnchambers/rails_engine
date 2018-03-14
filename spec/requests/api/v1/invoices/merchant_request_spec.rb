require "rails_helper"

describe "Invoice Merchant Request" do
  it "can return the associated merchant related to the invoice" do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant: merchant)

    get "/api/v1/invoices/#{invoice.id}/merchant"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(response.body).to match(merchant.to_json)
  end
end
