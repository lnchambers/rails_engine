require "rails_helper"

describe "Merchants Invoices request" do
  it "can return all invoices associated with a merchant" do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant: merchant)
    create_list(:invoice, 4, merchant: merchant)
    create(:invoice)

    get "/api/v1/merchants/#{merchant.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(invoices.count).to eq(5)
    expect(invoices[0]["status"]).to eq(invoice.status)
  end
end
