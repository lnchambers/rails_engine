class TransactionIntelligence

  def route(params)
    if params[:date]
      top_revenue_by_date(params)
    else
      total_revenue(params)
    end
  end

  def top_revenue_by_date(params)
    {"revenue" => '%.2f' % (Merchant.find(params[:merchant_id]).top_revenue_by_date(params[:date]).to_f / 100)}
  end

  def total_revenue(params)
    {"revenue" => '%.2f' % (Merchant.find(params[:merchant_id]).total_revenue.to_f / 100)}
  end

end
