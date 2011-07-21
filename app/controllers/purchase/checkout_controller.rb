class Purchase::CheckoutController < Purchase::PurchaseController
  before_filter :authenticate_account!

  def index
    if current_profile.has_wepay_auth_code?
      if wepay_access_token_exists?
        render :json => gateway.wepay_user
        return
      else
        initialize_wepay_access_token(current_profile.wepay_auth_code)
      end
    else
      redirect_to_wepay_for_auth
    end
  end
end