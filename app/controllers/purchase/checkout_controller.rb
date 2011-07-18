class Purchase::CheckoutController < Purchase::PurchaseController
  before_filter :authenticate_account!

  def index
    if current_profile.has_wepay_auth_code?
      File.open('/tmp/wepay.log', 'a') {|f| f.write("Inside index #{current_profile.wepay_auth_code}") }
      gateway.wepay_auth_code = current_profile.wepay_auth_code
      File.open('/tmp/wepay.log', 'a') {|f| f.write("Inside index, gateway.wepay_auth_code is #{gateway.wepay_auth_code}") }
      render :json => gateway.wepay_user
    else
      scope = ['refund_payments','collect_payments','view_balance','view_user']
      redirect_to_wepay_for_auth(wepay_authorize_index_url,scope)
    end
  end
end