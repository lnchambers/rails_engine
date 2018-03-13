class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_item_search

  def set_item_search
    @item_search = ItemSearch.new
  end
end
