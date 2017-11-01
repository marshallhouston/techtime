class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_cart
  helper_method :cart
  
  def set_cart
    @cart ||= Cart.new(session[:cart])
  end
end
