require "rails_helper"

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"

    expect(response).to be_success
    expect(response).to have_http_status(200)
    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(3)
    expect(response.body).to match(merchants.to_json)
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(response).to have_http_status(200)
    expect(merchant["id"]).to eq(id)
    expect(response.body).to match(merchant.to_json)
  end

  it "can locate a single merchant by name" do
    create_list(:merchant, 4, name: "Elizabeth-Blackburn")
    create_list(:merchant, 5)

    get "/api/v1/merchants/find?name=Elizabeth-Blackburn"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(response).to have_http_status(200)
    expect(response.body).to match(merchant.to_json)
  end

  it "can locate multiple merchants by name" do
    create_list(:merchant, 4, name: "Elizabeth-Blackburn")

    get "/api/v1/merchants/find_all?name=Elizabeth-Blackburn"

    merchants = JSON.parse(response.body)
    expect(merchants.count).to eq(4)
    expect(response).to be_success
    expect(response).to have_http_status(200)
    expect(response.body).to match(merchants.to_json)
  end

  it "can locate a random merchant" do
    create_list(:merchant, 10)

    get "/api/v1/merchants/random"

    merchant = JSON.parse(response.body)

    expect(response).to be_success
    expect(response).to have_http_status(200)
    expect(merchant.class).to eq(Hash)
    expect(response.body).to match(merchant.to_json)
  end
end
