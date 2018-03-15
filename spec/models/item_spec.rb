require 'rails_helper'

RSpec.describe Item, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:unit_price) }
  it { should belong_to(:merchant) }
  it { should have_many(:invoice_items) }
  it { should have_many(:invoices).through(:invoice_items) }

  describe "class methods" do
    before(:each) do
      @merchants = create_list(:merchant, 2)
      @customer = create(:customer)
      @item = create(:item, name: "Best Seller",unit_price: 2, merchant: @merchants[0])
      @item_2 = create(:item, name: "Worst Seller", unit_price: 20, merchant: @merchants[1])
      @invoice = create(:invoice, merchant: @merchants[0], customer: @customer, updated_at: "2018-02-03")
      @invoice_2 = create(:invoice, merchant: @merchants[1], customer: @customer, updated_at: "2018-02-04")

      create_list(:invoice_item, 10, item: @item, invoice: @invoice)
      create_list(:invoice_item, 2, item: @item_2, invoice: @invoice_2)
      create_list(:transaction, 10, invoice: @invoice)
      create_list(:transaction, 3, invoice: @invoice_2)
    end

    describe ".most_items" do
      it "returns the top x item instances ranked by total number sold" do
        expect(Item.most_items(2)).to eq([@item, @item_2])
        expect(Item.most_items(2).first.name).to eq(@item.name)
        expect(Item.most_items(2).last.name).to eq(@item_2.name)
      end
    end

    describe ".most_revenue" do
      it "returns the top x items ranked by total revenue generated" do
        expect(Item.most_revenue(2)).to eq([@item, @item_2])
        expect(Item.most_revenue(2).first.revenue).to eq(599900)
        expect(Item.most_revenue(2).last.revenue).to eq(119980)
      end
    end
  end

  describe "instance methods" do
    before(:each) do
      @merchants = create_list(:merchant, 2)
      @customer = create(:customer)
      @item = create(:item, name: "Best Seller",unit_price: 2, merchant: @merchants[0])
      @item_2 = create(:item, name: "Worst Seller", unit_price: 20, merchant: @merchants[1])
      @invoice = create(:invoice, merchant: @merchants[0], customer: @customer, updated_at: "2018-02-03")
      @invoice_2 = create(:invoice, merchant: @merchants[1], customer: @customer, updated_at: "2018-02-04")

      create_list(:invoice_item, 10, item: @item, invoice: @invoice)
      create_list(:invoice_item, 2, item: @item_2, invoice: @invoice_2)
      create_list(:transaction, 10, invoice: @invoice)
      create_list(:transaction, 3, invoice: @invoice_2)
    end

    describe "best_day" do
      it "returns the date with the most sales for the given item using the invoice date" do
        expect(Item.first.best_day.first.created_at.day).to eq(@invoice.created_at.day)
        expect(Item.first.best_day.last.created_at.day).to eq(@invoice_2.created_at.day)
      end
    end

  end
end
