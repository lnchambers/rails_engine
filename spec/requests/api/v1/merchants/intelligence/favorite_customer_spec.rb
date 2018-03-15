require "rails_helper"

describe "Favorite Customer" do
  it "can find a single merchants favorite customer" do

    get "/api/v1/merchants/1/favorite_customer"

  end
end
