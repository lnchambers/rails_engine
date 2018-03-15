require "rails_helper"

describe "Items Invoice Items Request" do
  it "can return the associated invoice items related to the item" do
    item = create(:item)
    invoice_item = create_list(:invoice_item, 3, item: item)

    get "/api/v1/items/#{item.id}/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(response.body).to match(invoice_items.to_json)
  end
end
