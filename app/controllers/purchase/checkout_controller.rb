class Purchase::CheckoutController < Purchase::PurchaseController
  before_filter :authenticate_account!

  def index
    if current_profile.has_wepay_auth_code?
      if wepay_access_token_exists?
        puts "CheckoutController#index if wepay_access_token_exists?"
      else
        puts "CheckoutController#index else"
        initialize_wepay_access_token(current_profile.wepay_auth_code)
        puts "CheckoutController#index after initialize_wepay_access_token call - sending #{current_profile.wepay_auth_code}"
      end
      gateway.wepay_auth_code = current_profile.wepay_auth_code
      render :json => gateway.wepay_user
    else
      scope = ['refund_payments','collect_payments','view_balance','view_user']
      redirect_to_wepay_for_auth(wepay_authorize_index_url, scope)
    end
  end
end