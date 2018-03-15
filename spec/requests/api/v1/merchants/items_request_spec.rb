require "rails_helper"

describe "Merchants Items request" do
  it "can return all items associated with a merchant" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    create_list(:item, 4, merchant: merchant)
    create(:item)

    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(items.count).to eq(5)
    expect(items[0]["name"]).to eq(item.name)
    expect(items[0]["description"]).to eq(item.description)
    expect(items[0]["unit_price"]).to eq("49.99")
  end
end
