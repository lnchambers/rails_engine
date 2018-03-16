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
      model.find_by("lower(name) LIKE ?", clean_name(params))
    elsif params[:merchant_id]
      model.find_by(merchant_id: params[:merchant_id])
    elsif params[:customer_id]
      model.find_by(customer_id: params[:customer_id])
    elsif params[:first_name]
      model.find_by("lower(first_name) LIKE ?", params[:first_name])
    elsif params[:last_name]
      model.find_by("lower(last_name) LIKE ?", params[:last_name])
    elsif params[:description]
      model.find_by("lower(description) LIKE ?", clean_description(params))
    elsif params[:unit_price]
      model.find_by(unit_price: price_search_format(params))
    elsif params[:created_at]
      model.find_by(created_at: Time.zone.parse(params[:created_at]))
    elsif params[:status]
      model.find_by("status LIKE ?", clean_status(params))
    elsif params[:quantity]
      model.find_by(quantity: params[:quantity])
    elsif params[:result]
      model.find_by(result: params[:result])
    elsif params[:credit_card_number]
      model.find_by(credit_card_number: params[:credit_card_number])
    elsif params[:item_id]
      model.find_by(item_id: params[:item_id])
    elsif params[:invoice_id]
      model.find_by(invoice_id: params[:invoice_id])
    elsif params[:updated_at]
      model.find_by(updated_at: Time.zone.parse(params[:updated_at]))
    elsif params[:id]
      model.find(params[:id])
    else
      random(model)
    end
  end

  def multiple_search(params, model)
    if params[:name]
      model.where("lower(name) LIKE ?", clean_name(params))
    elsif params[:first_name]
      model.where("lower(first_name) LIKE ?", params[:first_name])
    elsif params[:last_name]
      model.where("lower(last_name) LIKE ?", params[:last_name])
    elsif params[:merchant_id]
      model.where(merchant_id: params[:merchant_id])
    elsif params[:customer_id]
      model.where(customer_id: params[:customer_id])
    elsif params[:description]
      model.where("lower(description) LIKE ?", clean_description(params))
    elsif params[:unit_price]
      model.where(unit_price: price_search_format(params))
    elsif params[:created_at]
      model.where(created_at: Time.zone.parse(params[:created_at]))
    elsif params[:status]
      model.where("status LIKE ?", clean_status(params))
    elsif params[:quantity]
      model.where(quantity: params[:quantity])
    elsif params[:result]
      model.where(result: params[:result])
    elsif params[:credit_card_number]
      model.where(credit_card_number: params[:credit_card_number])
    elsif params[:updated_at]
      model.where(updated_at: Time.zone.parse(params[:updated_at]))
    elsif params[:item_id]
      model.where(item_id: params[:item_id])
    elsif params[:invoice_id]
      model.where(invoice_id: params[:invoice_id])
    elsif params[:id]
      [model.find(params[:id])]
    else
      model.all
    end
  end

  def random(model)
    model.all.sample
  end

  def price_search_format(params)
    params[:unit_price].gsub(".", "").to_i
  end

  def merchant(params)
    params[:controller].split("/")[-1] != "merchants"
  end

  def clean_name(params)
    if merchant(params)
      params[:name].gsub("-", " ").downcase
    else
      params[:name]
    end
  end

  def clean_description(params)
    params[:description].gsub("-", " ").downcase
  end

  def clean_status(params)
    params[:status].gsub("-", " ").downcase
  end

end
