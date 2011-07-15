class Wepay::AuthorizeController < Wepay::ApplicationController
  before_filter :authenticate_account!
  def index
    code = params[:code]
    current_profile.update_attribute(:wepay_auth_code, code)
    redirect_to new_purchase_checkout_path
  end
end