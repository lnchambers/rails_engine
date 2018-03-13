class MerchantSearch

  def route(params)
    case params[:id]
    when "find"
      single_search(params)
    when "find_all"
      multiple_search(params)
    when "random"
      random
    else
      Merchant.find(params[:id])
    end
  end

  def single_search(params)
    if params[:name]
      Merchant.find_by("lower(name) LIKE ?", params[:name])
    elsif params[:description]
      description = params[:description].gsub("-", " ").downcase
      Merchant.find_by("lower(description) LIKE ?", description)
    elsif params[:unit_price]
      Merchant.find_by("unit_price LIKE ?", params[:unit_price])
    elsif params[:created_at]
      Merchant.find_by("created_at LIKE ?", params[:created_at])
    else
      Merchant.find_by("updated_at LIKE ?", params[:updated_at])
    end
  end

  def multiple_search(params)
    if params[:name]
      Merchant.where("lower(name) LIKE ?", params[:name])
    elsif params[:description]
      description = params[:description].gsub("-", " ").downcase
      Merchant.where("lower(description) LIKE ?", description)
    elsif params[:unit_price]
      Merchant.where("unit_price LIKE ?", params[:unit_price])
    elsif params[:created_at]
      Merchant.where("created_at LIKE ?", params[:created_at])
    else
      Merchant.where("updated_at LIKE ?", params[:updated_at])
    end
  end

  def random
    Merchant.all.sample
  end

end
