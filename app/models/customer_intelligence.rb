class CustomerIntelligence

  def route(params, request)
    case clean_request(request)
    when "favorite_merchant"
      favorite_merchant(params)
    end
  end

  def favorite_merchant(params)
    Customer.find(params[:customer_id]).favorite_merchant
  end

  def clean_request(request)
    request.url.split("/")[-1].split("?")[0]
  end
end
