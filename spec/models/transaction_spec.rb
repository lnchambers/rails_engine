require 'rails_helper'
describe Transaction, type: :model do
  it {should validate_presence_of(:credit_card_number)}
  it {should validate_presence_of(:result)}
  it {should belong_to(:invoice)}

  describe "class methods" do
    before(:each) do
      @merchants = create_list(:merchant, 2)
      @customer = create(:customer)
      @customer2 = create(:customer)
      item = create(:item, name: "Best Seller",unit_price: 2, merchant: @merchants[0])
      item_2 = create(:item, name: "Worst Seller", unit_price: 20, merchant: @merchants[1])
      @invoice = create(:invoice, merchant: @merchants[0], customer: @customer, updated_at: "2018-02-03")
      @invoice_2 = create(:invoice, merchant: @merchants[1], customer: @customer2, updated_at: "2018-02-03")

      create_list(:invoice_item, 10, item: item, invoice: @invoice)
      create_list(:invoice_item, 2, item: item_2, invoice: @invoice_2)
      create_list(:transaction, 10, invoice: @invoice)
      create_list(:transaction, 3, invoice: @invoice_2)
    end

    describe "#total_revenue_by_date" do
      it "returns the total revenue for date x across all merchants" do
        expect(Transaction.total_revenue_by_date("2018-02-03")).to eq(6358940)
      end
    end
  end
end
