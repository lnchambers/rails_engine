# Rails Engine

This project utilizes Ruby on Rails and ActiveRecord to build a JSON API which exposes sales data selected from Etsy.

![schema](https://i.imgur.com/gzoHyeR.png)

## Table of Contents
- [Getting Started](#getting-started)
- [Prerequisites](#prequisites)
- [Installing](#installing)
- [Complex Queries](#complex-querying)
- [Running the Tests](#running-the-tests)
- [End to End Testing](#break-down-into-end-to-end-tests)
- [Coding Style Tests](#and-coding-style-tests)
- [Built With](#built-with)
- [Contributing](#contributing)
- [Authors](#authors)
- [Acknowledgements](#acknowledgments)

## Getting Started

These instructions will get you a copy of the rails engine API up and running on your local machine for development and testing purposes.

## Prerequisites


* Ruby, version 2.5
* Rails, version 5.1.5
* Puma, version 3.7
* Rspec-Rails
* Active Model Serializers, version 0.10.0
* Smarter CSV

* Add these system dependencies to your gem file then run

```
bundle
```

## Installing

* To configure the database run the following commands.

```
rails db:create
rails db:migrate
rake import_csv
```
* To import a specific csv for a model, see this [explanation](https://github.com/lnchambers/rails_engine/blob/master/csv_import.md)

## Complex Queries

* To view some complex data querying run the following:

```
rails c
Items.most_items
Items.most_revenue
Transaction.total_revenue_by_date("2012-03-16")
Merchant.first.customers_with_pending_invoices

```


## Running the tests
In order to run the test suite, open up the server in one terminal shell
```
rails s
```
Then in a new terminal shell, run the following command:
```
rspec
```

## Break down into end to end tests

* Simple Model Test:

The following test ensures that an invoice has a status and all the appropriate associated data.

```
rspec spec/models/invoice_spec.rb
```

* Complex Model Test:
The following test makes use ten separate [factorybot](https://github.com/thoughtbot/factory_bot)] factories to ensure that a merchant has a name and that it has all the appropriate associations(e.g., has many invoices_items through invoices). The class method ```.most_revenue``` selects the top merchants ranked by revenue. The class method ```.most_items``` selects the top merchants ranked by total number of items sold. The instance method ```#top_revenue_by_date```selects the total revenue for a specific merchant on an invoice date.

```
rspec spec/models/merchant_spec.rb
```

* Simple Request Test:

The following test ensures that all invoices associated with a specific customer are returned.

```
rspec spec/requests/api/v1/customers/invoices_request_spec.rb
```


* Complex Request Test:
When a request goes to the invoice_items record endpoint, a user can find an invoice item by id, unit_price, quantity or all invoice items matching a unit price or quantity.

```
rspec spec/requests/api/v1/invoice_items/invoice_items_request_spec.rb
```


## Built With

* [active model serializers](https://github.com/rails-api/active_model_serializers)
* [factorybot](https://github.com/thoughtbot/factory_bot)
* [database cleaner](https://github.com/DatabaseCleaner/database_cleaner)
* [shoulda matchers](https://github.com/thoughtbot/shoulda-matchers)


## Contributing

Please feel free to submit pull requests and suggestions to this repository. We would love your feedback.

## Authors

* [Luke Chambers](ttps://github.com/lnchambers)
* [Matt Milton](https://github.com/mgmilton)


## Acknowledgments

* Thanks to our wonderful instructors at [Turing](https://github.com/turingschool)
