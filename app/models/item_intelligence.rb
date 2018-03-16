class ItemIntelligence

  def route(params, request)
    case clean_request(request)
    when "most_items"
      most_items(params)
    when "most_revenue"
      most_revenue(params)
    when "best_day"
      best_day(params)
    end
  end

  def clean_request(request)
    request.url.split("/")[-1].split("?")[0]
  end

  def most_items(params)
    Item.most_items(params[:quantity])
  end

  def most_revenue(params)
    Item.most_revenue(params[:quantity])
  end

  def best_day(params)
    {"best_day" => Item.find(params[:item_id]).best_day.first.created_at}
  end
end
