class Purchase::CheckoutController < Purchase::PurchaseController
  include Wepay
  before_filter :authenticate_account!
  def index
    if current_profile.wepay_auth_code.present?

    else
      wepay = Wepay::Transport.new
      scope = ['refund_payments','collect_payments','view_balance','view_user']
      redirect_to wepay.auth_code_url(wepay_authorize_index_url,scope)
    end
  end
end