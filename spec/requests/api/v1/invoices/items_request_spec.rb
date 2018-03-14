require "rails_helper"

describe "Invoice Items Request" do
  it "can return all items under a specific invoice" do
    invoice = create(:invoice)
    item = create(:item)
    invoice_item = create(:invoice_item, item: item, invoice: invoice )



    get "/api/v1/invoices/#{invoice.id}/items"

    items = JSON.parse(response.body)
    expect(response).to be_success
    expect(items.count).to eq(1)
    expect(response.body).to match(items.to_json)
  end
end
