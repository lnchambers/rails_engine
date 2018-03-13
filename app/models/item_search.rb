class ItemSearch

  def route(params)
    case params[:id]
    when "find"
      item_single_search(params)
    when "find_all"
      item_multiple_search(params)
    when "random"
      random
    else
      Item.find(params[:id])
    end
  end

  def item_single_search(params)
    if params[:name]
      name = params[:name].gsub("-", " ").downcase
      Item.find_by("lower(name) LIKE ?", name)
    elsif params[:description]
      description = params[:description].gsub("-", " ").downcase
      Item.find_by("lower(description) LIKE ?", description)
    elsif params[:unit_price]
      Item.find_by("unit_price LIKE ?", params[:unit_price])
    elsif params[:created_at]
      Item.find_by("created_at LIKE ?", params[:created_at])
    else
      Item.find_by("updated_at LIKE ?", params[:updated_at])
    end
  end

  def item_multiple_search(params)
    if params[:name]
      name = params[:name].gsub("-", " ").downcase
      Item.where("lower(name) LIKE ?", name)
    elsif params[:description]
      description = params[:description].gsub("-", " ").downcase
      Item.where("lower(description) LIKE ?", description)
    elsif params[:unit_price]
      Item.where("unit_price LIKE ?", params[:unit_price])
    elsif params[:created_at]
      Item.where("created_at LIKE ?", params[:created_at])
    else
      Item.where("updated_at LIKE ?", params[:updated_at])
    end
  end

  def random
    random_id = rand(Item.count)
    Item.offset(random_id).first
  end

end
