class Purchase::CheckoutController < Purchase::PurchaseController
  before_filter :authenticate_account!

  def index
    if current_profile.has_wepay_auth_code?

    else
      scope = ['refund_payments','collect_payments','view_balance','view_user']
      redirect_to_wepay_for_auth(wepay_authorize_index_url,scope)
    end
  end
end