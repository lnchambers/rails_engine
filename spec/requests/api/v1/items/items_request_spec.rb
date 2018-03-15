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
    expect(items[0]["unit_price"]).to eq("49.99")
  end

  it "can show you a single item" do
    create_list(:item, 10)

    get "/api/v1/items/5"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item["name"]).to eq("Opakawagalaga Eupanifahorious")
    expect(item["description"]).to eq("Humphry Davenport The Second; Esquire, Duke of Portsholdshirelington")
    expect(item["unit_price"]).to eq("49.99")
    expect(item[1]).to eq(nil)
  end

  it "can search by name and return one" do
    create_list(:item, 5, name: "Richard Dunfordshirelingtonhill", description: "Argwillinillifus Grotcherinkleton", unit_price: 7999)
    create_list(:item, 5)

    get "/api/v1/items/find?name=Richard-Dunfordshirelingtonhill"

    item = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(item["name"]).to eq("Richard Dunfordshirelingtonhill")
    expect(item["description"]).to eq("Argwillinillifus Grotcherinkleton")
    expect(item["unit_price"]).to eq("79.99")
  end

  it "can search by description and return one" do
    create_list(:item, 5, name: "Richard Dunfordshirelingtonhill", description: "Argwillinillifus Grotcherinkleton", unit_price: 7999)
    create_list(:item, 5)

    get "/api/v1/items/find?description=Argwillinillifus-Grotcherinkleton"

    item = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(item["name"]).to eq("Richard Dunfordshirelingtonhill")
    expect(item["description"]).to eq("Argwillinillifus Grotcherinkleton")
    expect(item["unit_price"]).to eq("79.99")
  end

  it "can search by unit_price and return one" do
    create_list(:item, 5, name: "Richard Dunfordshirelingtonhill", description: "Argwillinillifus Grotcherinkleton", unit_price: 7999)
    create_list(:item, 5)

    get "/api/v1/items/find?unit_price=7999"

    item = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(item["name"]).to eq("Richard Dunfordshirelingtonhill")
    expect(item["description"]).to eq("Argwillinillifus Grotcherinkleton")
    expect(item["unit_price"]).to eq("79.99")
  end

  it "can search by name and return all" do
    create_list(:item, 5, name: "Richard Dunfordshirelingtonhill", description: "Argwillinillifus Grotcherinkleton", unit_price: 7999)
    create_list(:item, 5)

    get "/api/v1/items/find_all?name=Richard-Dunfordshirelingtonhill"

    item = JSON.parse(response.body)

    expect(response).to have_http_status(200)
    expect(item.count).to eq(5)
    expect(item[1]["name"]).to eq("Richard Dunfordshirelingtonhill")
    expect(item[1]["description"]).to eq("Argwillinillifus Grotcherinkleton")
    expect(item[1]["unit_price"]).to eq("79.99")
  end

  it "can find a random record" do
    create_list(:item, 5, name: "Richard Dunfordshirelingtonhill", description: "Argwillinillifus Grotcherinkleton", unit_price: 7999)
    create_list(:item, 5)

    get "/api/v1/items/random"

    item = JSON.parse(response.body)

    expect(response).to be_success
    expect(item.class).to eq(Hash)
  end

end
