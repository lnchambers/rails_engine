# An Explanation of the Endpoints in Rails Engine


## Record Endpoints
All of these record endpoints are available for all attributes for each data category (see the [schema](https://github.com/lnchambers/rails_engine)).

### Index
* ```GET localhost:3000/api/v1/invoices``` displays all the invoices.

### Show
* ```GET localhost:3000/api/v1/invoices/:id``` displays all a single specified invoice (:id).

### Single Find
Each data category offers ```find``` features to represent a single data object.

* ```GET localhost:3000/api/v1/invoices/find?id=2``` displays the invoice with an id of 2.
* ```GET localhost:3000/api/v1/invoices/find?status=shipped``` displays the first invoice with a status of shipped.
* ```GET localhost:3000/api/v1/invoices/find?customer_id=10``` displays the first invoice for the customer with an id of 10.
* ```GET localhost:3000/api/v1/invoices/find?merchant_id=92``` displays the first invoice for the merchant with an id of 92.


### MultiFind
Each data category offers a ```find_all``` feature that returns all matches for a given query.

* ```GET localhost:3000/api/v1/invoices/find_all?status=shipped``` displays all invoices with a status of shipped.
* ```GET localhost:3000/api/v1/invoices/find_all?customer_id=10``` displays all the invoices for the customer with an id of 10.
* ```GET localhost:3000/api/v1/invoices/find_all?merchant_id=92``` displays all the invoices for the merchant with an id of 92.

### Random Endpoint
Each data category offers a ```random``` feature that returns a random endpoint.

* ```GET localhost:3000/api/v1/invoices/random ```


## Relationship Endpoints

To expose relationship data from this API, the following nested URIs will return associated data for a given resource.

### Merchants
* ```GET localhost:3000/api/v1/merchants/:id/items``` returns a collection of items associated with a specified merchant.
* ```GET localhost:3000/api/v1/merchants/:id/invoices``` returns a collection of invoices associated with a specified merchant.

### Invoices
* ```GET localhost:3000/api/v1/invoices/:id/transactions``` returns a collection of associated transactions.
* ```GET localhost:3000/api/v1/invoices/:id/invoice_items``` returns a collection of associated invoice items.
* ```GET localhost:3000/api/v1/invoices/:id/items``` returns a collection of associated items.
* ```GET localhost:3000/api/v1/invoices/:id/customer``` returns the associated customer.
* ```GET localhost:3000/api/v1/invoices/:id/merchant``` returns the associated merchant.


### Invoice Items
* ```GET localhost:3000/api/v1/invoice_items/:id/invoice``` returns the associated invoice.
* ```GET localhost:3000/api/v1/invoice_items/:id/item``` returns the associated item.

### Items
* ```GET localhost:3000/api/v1/items/:id/invoice_items``` returns a collection of associated invoice items.
* ```GET localhost:3000/api/v1/items/:id/merchant``` returns the associated merhcant.


### Transactions
* ```GET localhost:3000/api/v1/transactions/:id/invoice``` returns the associated invoice.

### Customers
* ```GET localhost:3000/api/v1/customers/:id/invoices``` returns a collection of associated invoices.
* ```GET localhost:3000/api/v1/customers/:id/transactions``` returns a collection of associated transactions.

## Business Analytic Endpoints

### All Merchants
The following endpoints display analytics for all of the merchants.

* ```GET localhost:3000/api/v1/merchants/most_revenue?quantity=x``` returns the top ```x``` merchants ranked by the total revenue.
* ```GET localhost:3000/api/v1/merchants/most_items?quantity=x``` returns the top ```x``` merchants ranked by the total number of items sold.
* ```GET localhost:3000/api/v1/merchants/most_revenue?date=x``` returns the total revenue for all merchants on date ```x```.

### Single Merchant
The following endpoints display analytics for a single merchant.

* ```GET localhost:3000/api/v1/merchants/:id/revenue``` returns the total revenue for a specified merchant (:id) across successful transactions.
* ```GET localhost:3000/api/v1/merchants/:id/revenue?date=x``` returns the total revenue for a specified merchant (:id) on a specific date ```x```.
* ```GET localhost:3000/api/v1/merchants/:id/favorite_customer``` returns the customer who has conducted the most total number of successful transactions for a specified merchant (:id).
* ```GET localhost:3000/api/v1/merchants/:id/customers_with_pending_invoices``` returns a collection of customers which have unpaid invoices for a specified merchant (:id).

### Items
The following endpoints display analytics for all items.

* ```GET localhost:3000/api/v1/items/most_revenue?quantity=x``` returns the top ```x``` items ranked by total revenue generated.
* ```GET localhost:3000/api/v1/items/most_items?quantity=x``` returns the top ```x``` items ranked by total number sold

### Single Item
The following endpoint displays analytic information for a single item.

* ```GET localhost:3000/api/v1/items/:id/best_day``` returns the top the date with the most sales for a given item using the invoice date. If there are multiple dates, the most recent day is returned.

### Single Customer
The following endpoint displays analytic information for a single customer.

* ```GET localhost:3000/api/v1/customers/:id/favorite_merchant``` returns a merchant where a specified customer (:id) has conducted the most successful transactions.
