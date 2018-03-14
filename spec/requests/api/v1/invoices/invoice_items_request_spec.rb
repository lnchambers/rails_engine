require "rails_helper"

describe "Invoice Invoice Items Request" do
  it "can return all invoice items under a specific invoice" do
    invoice = create(:invoice)
    invoice_items = create_list(:invoice_item, 3, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(3)
    expect(response.body).to match(invoice_items.to_json)

  end
end
