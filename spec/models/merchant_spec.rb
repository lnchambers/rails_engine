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
      item = create(:item, name: "Best Seller",unit_price: 2, merchant: @merchants[0])
      item_2 = create(:item, name: "Worst Seller", unit_price: 20, merchant: @merchants[1])
      invoice = create(:invoice, merchant: @merchants[0])
      invoice_2 = create(:invoice, merchant: @merchants[1])
      create_list(:invoice_item, 10, item: item, invoice: invoice)
      create_list(:invoice_item, 2, item: item_2, invoice: invoice_2)
      create_list(:transaction, 10, invoice: invoice)
      create_list(:transaction, 3, invoice: invoice_2)
    end

    describe ".most_revenue" do
      it "returns the top x merchants ranked by revenue" do
        expect(Merchant.most_revenue(2)).to eq(@merchants)
        expect(Merchant.most_revenue.first.revenue).to eq(5999000)
        expect(Merchant.most_revenue.last.revenue).to eq(359940)
      end
    end


    describe ".most_items" do
      it "returns the top x merchants ranked by total number of items sold" do
        expect(Merchant.most_items(2)).to eq(@merchants)
        expect(Merchant.most_items(2).first.items.first.name). to eq("Best Seller")
        expect(Merchant.most_items(2).last.items.first.name). to eq("Worst Seller")
      end
    end
  end

  describe "instance methods" do
    before(:each) do
      @merchants = create_list(:merchant, 2)
      @customer = create(:customer)
      @customer_two = create(:customer)
      @customer_three = create(:customer)
      item = create(:item, name: "Best Seller",unit_price: 2, merchant: @merchants[0])
      item_2 = create(:item, name: "Worst Seller", unit_price: 20, merchant: @merchants[1])
      @invoice = create(:invoice, merchant: @merchants[0], customer: @customer, updated_at: "2018-02-03")
      @invoice_2 = create(:invoice, merchant: @merchants[1], customer: @customer, updated_at: "2018-02-04")
      @invoice_3 = create(:invoice, merchant: @merchants[0], customer: @customer_two, updated_at: "2018-02-04")
      @invoice_4 = create(:invoice, merchant: @merchants[0], customer: @customer_three, updated_at: "2018-02-04")

      create_list(:invoice_item, 10, item: item, invoice: @invoice)
      create_list(:invoice_item, 2, item: item_2, invoice: @invoice_2)
      create_list(:transaction, 10, invoice: @invoice)
      create_list(:transaction, 3, invoice: @invoice_2)
      create_list(:transaction, 3, invoice: @invoice_3, result: "failed")
      create_list(:transaction, 9, invoice: @invoice_4, result: "failed")
    end

    describe "#total revenue" do
      it "returns the total revenue for that merchant across successful transactions" do
        expect(Merchant.first.total_revenue).to eq(5999000)
        expect(Merchant.last.total_revenue).to eq(359940)
      end
    end

    describe "#top_revenue_by_date" do
      it "returns the total revenue for that merchant for a specific invoice date x" do
        expect(Merchant.first.top_revenue_by_date("2018-02-03")).to eq(5999000)
        expect(Merchant.last.top_revenue_by_date("2018-02-04")).to eq(359940)
      end
    end

    describe "#favorite_customer" do
      it "returns the customer who has conducted the most total number of successful transactions" do
        expect(Merchant.first.favorite_customer).to eq(@customer)
        expect(Merchant.last.favorite_customer).to eq(@customer)
      end
    end

    describe "#customers_with_pending_invoices" do
      it "returns a collection of customers which have pending (unpaid) invoices" do
        expect(Merchant.first.customers_with_pending_invoices).to eq([@customer_two, @customer_three])
      end
    end
  end
end
