class Search

  def route(params, model)
    case params[:action]
    when "show"
      single_search(params, model)
    when "index"
      multiple_search(params, model)
    end
  end

  def single_search(params, model)
    if params[:name]
      name = params[:name].gsub("-", " ").downcase
      model.find_by("lower(name) LIKE ?", name)
    elsif params[:merchant_id]
      model.find_by(merchant_id: params[:merchant_id])
    elsif params[:customer_id]
      model.find_by(customer_id: params[:customer_id])
    elsif params[:first_name]
      model.find_by("lower(first_name) LIKE ?", params[:first_name])
    elsif params[:last_name]
      model.find_by("lower(last_name) LIKE ?", params[:last_name])
    elsif params[:description]
      description = params[:description].gsub("-", " ").downcase
      model.find_by("lower(description) LIKE ?", description)
    elsif params[:unit_price]
      model.find_by("unit_price LIKE ?", params[:unit_price])
    elsif params[:created_at]
      model.find_by(created_at: Time.zone.parse(params[:created_at]))
    elsif params[:status]
      status = params[:status].gsub("-", " ").downcase
      model.find_by("status LIKE ?", status)
    elsif params[:quantity]
      model.find_by("quantity LIKE ?", params[:quantity])
    elsif params[:result]
      model.find_by("result LIKE ?", params[:result])
    elsif params[:credit_card_number]
      model.find_by("credit_card_number LIKE ?", params[:credit_card_number])
    elsif params[:updated_at]
      model.find_by(updated_at: Time.zone.parse(params[:updated_at]))
    elsif params[:id]
      model.find_by(id: params[:id])
    else
      random(model)
    end
  end

  def multiple_search(params, model)
    if params[:name]
      name = params[:name].gsub("-", " ").downcase
      model.where("lower(name) LIKE ?", name)
    elsif params[:first_name]
      model.find_by("lower(first_name) LIKE ?", params[:first_name])
    elsif params[:last_name]
      model.find_by("lower(last_name) LIKE ?", params[:last_name])
    elsif params[:merchant_id]
      model.where(merchant_id: params[:merchant_id])
    elsif params[:customer_id]
      model.where(customer_id: params[:customer_id])
    elsif params[:description]
      description = params[:description].gsub("-", " ").downcase
      model.where("lower(description) LIKE ?", description)
    elsif params[:unit_price]
      model.where("unit_price LIKE ?", params[:unit_price])
    elsif params[:created_at]
      model.where(created_at: Time.zone.parse(params[:created_at]))
    elsif params[:status]
      status = params[:status].gsub("-", " ").downcase
      model.where("status LIKE ?", status)
    elsif params[:quantity]
      model.where("quantity LIKE ?", params[:quantity])
    elsif params[:result]
      model.where("result LIKE ?", params[:result])
    elsif params[:credit_card_number]
      model.where("credit_card_number LIKE ?", params[:credit_card_number])
    elsif params[:updated_at]
      model.where(updated_at: Time.zone.parse(params[:updated_at]))
    elsif params[:id]
      [model.find(params[:id])]
    else
      model.all
    end
  end

  def random(model)
    model.all.sample
  end

end
