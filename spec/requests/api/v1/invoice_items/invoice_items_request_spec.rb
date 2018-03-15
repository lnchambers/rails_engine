require "rails_helper"

describe "Invoice_Item Request" do
  it "can show you all of the invoice_items" do
    create_list(:invoice_item, 10)

    get "/api/v1/invoice_items"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(10)
    expect(invoice_items[0]["unit_price"]).to eq("59.99")
    expect(invoice_items[0]["quantity"]).to eq(10)
  end

  it "can show you one invoice_item" do
    create_list(:invoice_item, 10)

    get "/api/v1/invoice_items/5"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(response).to be_success
    expect(invoice_item["unit_price"]).to eq("59.99")
    expect(invoice_item["quantity"]).to eq(10)
  end

  it "can search by unit_price and return one" do
    create_list(:invoice_item, 5, unit_price: 9999, quantity: 5)
    create_list(:invoice_item, 5)

    get "/api/v1/invoice_items/find?unit_price=9999"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["unit_price"]).to eq("99.99")
    expect(invoice_item["quantity"]).to eq(5)
  end

  it "can search by quantity and return one" do
    create_list(:invoice_item, 5, unit_price: 9999, quantity: 5)
    create_list(:invoice_item, 5)

    get "/api/v1/invoice_items/find?quantity=5"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item["unit_price"]).to eq("99.99")
    expect(invoice_item["quantity"]).to eq(5)
  end

  it "can search by unit_price and return all" do
    create_list(:invoice_item, 5, unit_price: 9999, quantity: 5)
    create_list(:invoice_item, 5)

    get "/api/v1/invoice_items/find_all?unit_price=9999"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(5)
    expect(invoice_items[0]["unit_price"]).to eq("99.99")
    expect(invoice_items[0]["quantity"]).to eq(5)
  end

  it "can search by quantity and return all" do
    create_list(:invoice_item, 5, unit_price: 9999, quantity: 5)
    create_list(:invoice_item, 5)

    get "/api/v1/invoice_items/find_all?quantity=5"

    invoice_items = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_items.count).to eq(5)
    expect(invoice_items[0]["unit_price"]).to eq("99.99")
    expect(invoice_items[0]["quantity"]).to eq(5)
  end

  it "can return a random invoice for some reason" do
    create_list(:invoice_item, 10)

    get "/api/v1/invoice_items/random"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice_item.class).to eq(Hash)
  end
end
