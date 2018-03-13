require "rails_helper"

describe "Items Request" do
  it "can show you all of the items" do
    create_list(:item, 10)

    get "/api/v1/items"

    items = JSON.parse(response.body)

    expect(response).to be_success
    expect(items.count).to eq(10)
    expect(items[0]["name"]).to eq("Opakawagalaga Eupanifahorious")
    expect(items[0]["description"]).to eq("Humphry Davenport The Second; Esquire, Duke of Portsholdshirelington")
    expect(items[0]["unit_price"]).to eq(4999)
  end

  it "can show you a single item" do
    create_list(:item, 10)

    get "/api/v1/items/5"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["name"]).to eq("Opakawagalaga Eupanifahorious")
    expect(item["description"]).to eq("Humphry Davenport The Second; Esquire, Duke of Portsholdshirelington")
    expect(item["unit_price"]).to eq(4999)
    expect(item[1]).to eq(nil)
  end
end
