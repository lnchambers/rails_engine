require "rails_helper"

describe "Invoice Items Invoice Request" do
  it "can return the associated invoice related to the invoice_item" do
    invoice = create(:invoice)
    invoice_item = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(response.body).to match(invoice.to_json)
  end
end
