class MerchantIntelligence

  def route(params)
    merchant_most_revenue(params)
  end

  def merchant_most_revenue(params)
    Merchant.most_revenue(params[:quantity])
  end

end
