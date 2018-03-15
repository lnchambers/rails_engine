namespace :import_csv do
  desc "import_customers.csv"
  task create_customers: :environment do
    SmarterCSV.process("data/customers.csv").each do|row|
      Customer.create!(row)
    end
  end

  desc "import_invoice_items.csv"
  task create_invoice_items: :environment do
    SmarterCSV.process("data/invoice_items.csv").each do|row|
      InvoiceItem.create!(row)
    end
  end

  desc "import_invoices.csv"
  task create_invoices: :environment do
    SmarterCSV.process("data/invoices.csv").each do |row|
      Invoice.create!(row)
    end
  end

  desc "import_items.csv"
  task create_items: :environment do
    SmarterCSV.process("data/items.csv").each do|row|
      Item.create!(row)
    end
  end

  desc "import_merchants.csv"
  task create_merchants: :environment do
    SmarterCSV.process("data/merchants.csv").each do|row|
      Merchant.create!(row)
    end
  end

  desc "import_transactions.csv"
  task create_transactions: :environment do
    SmarterCSV.process("data/transactions.csv").each do|row|
      Transaction.create!(row)
    end
  end
end

desc "import_all"
task import_csv: :environment do
  ot = Time.now
  puts "Importing the Merchants"
  t1 = Time.now
  Rake::Task['import_csv:create_merchants'].invoke
  t2 = Time.now
  puts "Spent #{(t2 - t1).round(2)} seconds importing Merchants"

  puts "Importing the Customers"
  t1 = Time.now
  Rake::Task['import_csv:create_customers'].invoke
  t2 = Time.now
  puts "Spent #{(t2 - t1).round(2)} seconds importing Customers"


  puts "Importing the Items"
  t1 = Time.now
  Rake::Task['import_csv:create_items'].invoke
  t2 = Time.now
  puts "Spent #{(t2 - t1).round(2)} seconds importing Items"

  puts "Importing the Invoices"
  t1 = Time.now
  Rake::Task['import_csv:create_invoices'].invoke
  t2 = Time.now
  puts "Spent #{(t2 - t1).round(2)} seconds importing Invoices"

  puts "Importing the Transactions"
  t1 = Time.now
  Rake::Task['import_csv:create_transactions'].invoke
  t2 = Time.now
  puts "Spent #{(t2 - t1).round(2)} seconds importing Transactions"

  puts "Importing the Invoice Items"
  t1 = Time.now
  Rake::Task['import_csv:create_invoice_items'].invoke
  t2 = Time.now
  puts "Spent #{(t2 - t1).round(2)} seconds importing Invoice Items for a total of #{(t2 - ot).round(2)} seconds"
end
