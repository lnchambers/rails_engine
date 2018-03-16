class MerchantIntelligence

  def route(params, request)
    case clean_request(request)
    when "favorite_customer"
      favorite_customer(params)
    when "most_revenue"
      most_revenue(params)
    when "revenue"
      all_merchants_top_revenue_by_date(params)
    when "most_items"
      most_items(params)
    when "customers_with_pending_invoices"
      customers_with_pending_invoices(params)
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

  def all_merchants_top_revenue_by_date(params)
    {"total_revenue" => '%.2f' % (Transaction.total_revenue_by_date(params[:date]).to_f / 100)}
  end

  def customers_with_pending_invoices(params)
    Merchant.find(params[:merchant_id]).customers_with_pending_invoices
  end
end
