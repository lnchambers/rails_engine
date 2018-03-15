class MerchantIntelligence

  def route(params, request)
    # binding.pry
    case clean_request(request)
    when "favorite_customer"
      favorite_customer(params)
    when "most_revenue"
      most_revenue(params)
    when "revenue" && params[:merchant_id] && params[:date]
      top_revenue_by_date(params)
    when "revenue" && params[:merchant_id]
      total_revenue(params)
    when "revenue"
      all_merchants_top_revenue_by_date(params)
    when "most_items"
      most_items(params)
    end
  end

  def clean_request(request)
    request.url.split("/")[-1].split("?")[0]
  end

  def most_revenue(params)
    Merchant.most_revenue(params[:quantity])
  end

  def favorite_customer(params)
    Merchant.find(params[:merchant_id]).favorite_customer
  end

  def most_items(params)
    Merchant.most_items(params[:quantity])
  end

  def top_revenue_by_date(params)
    Merchant.find(params[:merchant_id]).top_revenue_by_date(params[:date])
  end

  def total_revenue(params)
    Merchant.find(params[:merchant_id]).total_revenue
  end

  def all_merchants_top_revenue_by_date(params)
    Transaction.total_revenue_by_date(params[:date])
  end
end
