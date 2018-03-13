require "rails_helper"

describe "Invoice Request" do
  it "can show you all of the invoices" do
    create_list(:invoice, 10)

    get "/api/v1/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(10)
    expect(invoices[0]["status"]).to eq("It's Complicated")
  end

  it "can show you one invoice" do
    create_list(:invoice, 10)

    get "/api/v1/invoice/5"

    invoice = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoice["status"]).to eq("It's Complicated")
  end
end
