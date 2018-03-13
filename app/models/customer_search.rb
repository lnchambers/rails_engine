class CustomerSearch

  def route(params)
    case params[:id]
    when "find"
      single_search(params)
    when "find_all"
      multiple_search(params)
    when "random"
      random
    else
      Customer.find(params[:id])
    end
  end

  def single_search(params)
    if params[:name]
      Customer.find_by("lower(name) LIKE ?", params[:name])
    elsif params[:description]
      description = params[:description].gsub("-", " ").downcase
      Customer.find_by("lower(description) LIKE ?", description)
    elsif params[:unit_price]
      Customer.find_by("unit_price LIKE ?", params[:unit_price])
    elsif params[:created_at]
      Customer.find_by("created_at LIKE ?", params[:created_at])
    else
      Customer.find_by("updated_at LIKE ?", params[:updated_at])
    end
  end

  def multiple_search(params)
    if params[:name]
      Customer.where("lower(name) LIKE ?", params[:name])
    elsif params[:description]
      description = params[:description].gsub("-", " ").downcase
      Customer.where("lower(description) LIKE ?", description)
    elsif params[:unit_price]
      Customer.where("unit_price LIKE ?", params[:unit_price])
    elsif params[:created_at]
      Customer.where("created_at LIKE ?", params[:created_at])
    else
      Customer.where("updated_at LIKE ?", params[:updated_at])
    end
  end

  def random
    Customer.all.sample
  end

end
