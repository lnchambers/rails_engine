require "rails_helper"

describe "Total Revenue Request" do
  before :each do
    @merchants = create_list(:merchant, 2)
    item = create(:item, name: "Best Seller",unit_price: 2, merchant: @merchants[0])
    item_2 = create(:item, name: "Worst Seller", unit_price: 20, merchant: @merchants[1])
    invoice = create(:invoice, merchant: @merchants[0])
    invoice_2 = create(:invoice, merchant: @merchants[1])
    create_list(:invoice_item, 10, item: item, invoice: invoice)
    create_list(:invoice_item, 2, item: item_2, invoice: invoice_2)
    create_list(:transaction, 10, invoice: invoice)
    create_list(:transaction, 3, invoice: invoice_2)
  end
  it "can return the total revenue by date" do
    get "/api/v1/merchants/1/revenue?date=2012-03-16"

    expect(response).to be_success
    expect(response.body).to eq("12")
  end
end
