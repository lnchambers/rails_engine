require "rails_helper"

describe "Items Merchant Request" do
  it "can return the associated merchant related to the item" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchant"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(response.body).to match(merchant.to_json)
  end
end
