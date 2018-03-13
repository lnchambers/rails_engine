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

  it "can locate a single merchant" do
    id = create(:merchant).id



  end
end
