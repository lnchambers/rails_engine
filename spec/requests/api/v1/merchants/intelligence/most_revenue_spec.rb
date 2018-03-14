require "rails_helper"

describe "Most Revenue" do
  it "can return a specified number of merchants with the highest revenue" do
    merchant = create(:merchant)

    get "/api/v1/merchants/most_revenue?quantity=5"

  end
end
