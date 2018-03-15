require "rails_helper"

describe "Invoice Items Item Request" do
  it "can return the associated invoice related to the item" do
    item = create(:item)
    invoice_item = create(:invoice_item, item: item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(response.body).to match(item.to_json)
  end
end
