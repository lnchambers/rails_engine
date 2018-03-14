require "rails_helper"

describe "Transactions API" do
  it "sends a list of transactions" do
    create_list(:transaction, 3)

    get "/api/v1/transactions"

    expect(response).to be_success

    transactions = JSON.parse(response.body)
    expect(transactions.count).to eq(3)
  end



  it "can get one transaction by its id" do
    id = create(:transaction).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)
    expect(response).to be_success
    expect(transaction["id"]).to eq(id)
  end

  it "can locate a single transaction by result" do
    create_list(:transaction, 4, result: "success")
    create_list(:transaction, 5)

    get "/api/v1/transactions/find?result=success"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(response).to have_http_status(200)
    expect(response.body).to match(transaction.to_json)
  end

  it "can locate multiple transactions by results" do
    create_list(:transaction, 4, result: "success")


    get "/api/v1/transactions/find_all?result=success"

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(4)
    expect(response).to be_success
    expect(response).to have_http_status(200)
    expect(response.body).to match(transactions.to_json)
  end

  it "can locate a single transaction by credit card number" do
    create_list(:transaction, 4, credit_card_number: 2)
    create_list(:transaction, 5)

    get "/api/v1/transactions/find?credit_card_number=#{2}"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(response).to have_http_status(200)
    expect(response.body).to match(transaction.to_json)
  end

  it "can locate multiple transactions by credit card number" do
    create_list(:transaction, 4, credit_card_number: 2)


    get "/api/v1/transactions/find_all?credit_card_number=#{2}"

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(4)
    expect(response).to be_success
    expect(response).to have_http_status(200)
    expect(response.body).to match(transactions.to_json)
  end

  it "can locate a random transaction" do
    create_list(:transaction, 10)

    get "/api/v1/transactions/random"

    transaction = JSON.parse(response.body)

    expect(response).to be_success
    expect(response).to have_http_status(200)
    expect(transaction.class).to eq(Hash)
    expect(response.body).to match(transaction.to_json)
  end

end
