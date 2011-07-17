class Wepay::AuthorizeController < Wepay::ApplicationController
  before_filter :authenticate_account!
  def index
    code = params[:code]
    current_profile.update_attribute(:wepay_auth_code, code)
    redirect_to purchase_checkout_index_path
  end
end