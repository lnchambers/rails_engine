require "csv"
namespace :import_csv do
    desc "imports customers.csv"
    task create_customers: :environment do
      csv_text = File.read("data/customers.csv")
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        Customer.create!(row.to_hash)
      end
    end

    desc "import invoice_items.csv"
    task create_invoice_items: :environment do
      csv_text = File.read("data/invoice_items.csv")
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        InvoiceItem.create!(row.to_hash)
      end
    end

    desc "import_invoies.csv"
    task create_invoices: :environment do
      csv_text = File.read("data/invoices.csv")
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        Invoice.create!(row.to_hash)
      end
    end

    desc "import_items.csv"
    task create_items: :environment do
      csv_text = File.read("data/items.csv")
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        Item.create!(row.to_hash)
      end
    end

    desc "import_merchants.csv"
    task create_merchants: :environment do
      csv_text = File.read("data/merchants.csv")
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        Merchant.create!(row.to_hash)
      end
    end

    desc "import_transactions.csv"
    task create_transactions: :environment do
      csv_text = File.read("data/transactions.csv")
      csv = CSV.parse(csv_text, :headers => true)
      csv.each do |row|
        Transaction.create!(row.to_hash)
      end
    end
end
