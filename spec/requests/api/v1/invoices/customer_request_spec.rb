require "rails_helper"

describe "Invoice Customer Request" do
  it "can return the associated customer related to the invoice" do
    customer = create(:customer)
    invoice = create(:invoice, customer: customer)

    get "/api/v1/invoices/#{invoice.id}/customer"

    customer = JSON.parse(response.body)

    expect(response).to be_success
    expect(response.body).to match(customer.to_json)
  end
end
