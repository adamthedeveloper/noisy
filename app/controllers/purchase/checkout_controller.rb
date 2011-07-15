class Purchase::CheckoutController < Purchase::PurchaseController
  before_filter :authenticate_account!

  def index
    if current_profile.wepay_auth_code.present?

    else
      scope = ['refund_payments','collect_payments','view_balance','view_user']
      redirect_to gateway.auth_code_url(wepay_authorize_index_url,scope)
    end
  end
end