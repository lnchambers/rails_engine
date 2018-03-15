class MerchantSearch

  def route(params)
    case params[:action]
    when "show"
      single_search(params)
    when "index"
      multiple_search(params)
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
      Merchant.find_by(created_at: Time.zone.parse(params[:created_at]))
    elsif params[:updated_at]
      Merchant.find_by(updated_at: Time.zone.parse(params[:updated_at]))
    elsif params[:id]
      Merchant.find_by(id: params[:id])
    else
      random
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
      Merchant.where(created_at: Time.zone.parse(params[:created_at]))
    elsif params[:updated_at]
      Merchant.where(updated_at: Time.zone.parse(params[:updated_at]))
    elsif params[:id]
      [Merchant.find(params[:id])]
    else
      Merchant.all
    end
  end

  def random
    Merchant.all.sample
  end

end
