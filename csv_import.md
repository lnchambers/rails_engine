# How to Create A Rake CSV Importer
```
rails g task import_csv create_customers create_invoice_items create_invoices create_items create_merchants create_transactions
```
- In ```lib/tasks/import_csv```
- Create a migration for customers where attributes correspond to column headers in csv ```rails g model customer first_name last_name```
- Here's how you would structure the import customer csv task the customers csv
```ruby
namespace :import_csv do
  desc "imports customers.csv"
  task create_customers: :environment do
    csv_text = File.read("data/customers.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Customer.create!(row.to_hash)
    end
  end

```
- Run ```rake import_csv:create_customers``` to seed the database
- For more information look [here](https://stackoverflow.com/questions/12461260/how-can-i-import-a-csv-file-via-a-rake-task)
