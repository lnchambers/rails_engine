require 'rails_helper'

describe Merchant, type: :model do
  it {should validate_presence_of :name}
  it { should have_many(:invoices) }
  it { should have_many(:items) }
  it { should have_many(:invoice_items).through(:invoices) }
  it { should have_many(:invoice_items).through(:invoices) }
  it { should have_many(:customers).through(:invoices) }

  describe "class methods" do
    before(:each) do
      @merchants = create_list(:merchant, 2)
      item = create(:item, unit_price: 2, merchant: @merchants[0])
      item_2 = create(:item, unit_price: 20, merchant: @merchants[1])
      invoice = create(:invoice, merchant: @merchants[0])
      invoice_2 = create(:invoice, merchant: @merchants[1])
      create_list(:invoice_item, 10, item: item, invoice: invoice)
      create_list(:invoice_item, 2, item: item_2, invoice: invoice_2)
      create_list(:transaction, 10, invoice: invoice)
      create_list(:transaction, 3, invoice: invoice_2)
    end

    describe ".most_revenue" do
      it "returns the top x merchants ranked by revenue" do
        binding.pry
        expect(Merchant.most_revenue(2)).to eq(@merchants)
        expect(Merchant.most_revenue.first).to eq(5999000)
        expect(Merchant.most_revenue.first).to eq(359940)
      end
    end
  end

  describe "instance methods" do

  end
end
