class ButcherShopController < ActionController::API
  include ActionController::MimeResponds

  def respond_with
    raise ArgumentError, 'what the heck are you doing?'
  end

end
