module ApiMethods
  extend ActiveSupport::Concern

  def single_find
    if params[:id]
      merchant = Merchant.find(merchant_params[:id])
    elsif params[:name]
      merchant =  Merchant.find_by(name: merchant_params[:name])
    elsif params[:created_at]
      merchant = Merchant.find_by(created_at: merchant_params[:created_at])
    elsif params[:updated_at]
      merchant = Merchant.find_by(updated_at: merchant_params[:updated_at])
    end
    render json: merchant
  end

  def find_all
    Merchant.where(merchant_params)
  end

  def random
    Merchant.all.sample
  end

end
