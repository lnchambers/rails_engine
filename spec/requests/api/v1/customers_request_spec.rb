require "rails_helper"

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get "/api/v1/customers"

    expect(response).to be_success
    expect(response).to have_http_status(200)
    customers = JSON.parse(response.body)
    expect(customers.count).to eq(3)
    expect(response.body).to match(customers.to_json)
  end

  it "can get one customer by its id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(response).to have_http_status(200)
    expect(customer["id"]).to eq(id)
    expect(response.body).to match(customer.to_json)
  end

  it "can locate a customer by first name" do
    create_list(:customer, 10, first_name: "Joey")
    create_list(:customer, 10)

    get "/api/v1/customers/find?first_name=Joey"

    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(response).to have_http_status(200)
    expect(response.body).to match(customers.to_json)
  end

  it "can locate a customer by last name" do
    create_list(:customer, 10, last_name: "Ramone")
    create_list(:customer, 10)

    get "/api/v1/customers/find?last_name=Ramone"

    customers = JSON.parse(response.body)

    expect(response).to be_success
    expect(response).to have_http_status(200)
    expect(response.body).to match(customers.to_json)
  end

  it "can locate a random customer" do
    create_list(:customer, 10)

    get "/api/v1/customers/random"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(response).to have_http_status(200)
    expect(customer.class).to eq(Hash)
    expect(response.body).to match(customer.to_json)
  end
end
