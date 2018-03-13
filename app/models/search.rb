class Search

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
    elsif params[:updated_at]
      Item.find_by("updated_at LIKE ?", params[:updated_at])
    else
      Item.find(params[:id])
    end
  end

end
