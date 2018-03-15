class MerchantIntelligence

  def route(params)
    binding.pry
    case params[:action]
    when "show"
      favorite_customer
    when "index"
      most_revenue(params)
    end
  end

  def most_revenue(params)
    Merchant.most_revenue(params[:quantity])
  end

  def favorite_customer
    Merchant.favorite_customer
  end

end
