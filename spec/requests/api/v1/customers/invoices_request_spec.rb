require "rails_helper"

describe "Customer Invoice Request" do
  it "can return all invoices under a specific customer" do
    customer = create(:customer)
    invoice = create(:invoice, customer: customer)
    create(:invoice)
    create_list(:invoice, 4, customer: customer)

    get "/api/v1/customers/#{customer.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_success
    expect(invoices.count).to eq(5)
    expect(invoices[0]["status"]).to eq(invoice.status)
  end
end
