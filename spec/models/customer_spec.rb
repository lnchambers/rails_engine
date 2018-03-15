require 'rails_helper'

describe Customer, type: :model do
  it {should validate_presence_of(:first_name)}
  it {should validate_presence_of(:last_name)}
  it {should have_many(:invoices)}
  it {should have_many(:merchants).through(:invoices)}
  it {should have_many(:transactions).through(:invoices)}

  describe "instance methods" do
    before(:each) do
      @merchants = create_list(:merchant, 2)
      @customer = create(:customer)
      @customer2 = create(:customer)
      item = create(:item, name: "Best Seller",unit_price: 2, merchant: @merchants[0])
      item_2 = create(:item, name: "Worst Seller", unit_price: 20, merchant: @merchants[1])
      @invoice = create(:invoice, merchant: @merchants[0], customer: @customer, updated_at: "2018-02-03")
      @invoice_2 = create(:invoice, merchant: @merchants[1], customer: @customer2, updated_at: "2018-02-04")

      create_list(:invoice_item, 10, item: item, invoice: @invoice)
      create_list(:invoice_item, 2, item: item_2, invoice: @invoice_2)
      create_list(:transaction, 10, invoice: @invoice)
      create_list(:transaction, 3, invoice: @invoice_2)
    end

    describe "#favorite_merchant" do
      it "returns the customer who has conducted the most total number of successful transactions" do
        expect(Customer.first.favorite_merchant).to eq(@merchants[0])
        expect(Customer.last.favorite_merchant).to eq(@merchants[1])
      end
    end
  end
end
