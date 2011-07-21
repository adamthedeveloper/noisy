class Wepay::AuthorizeController < Wepay::ApplicationController
  before_filter :authenticate_account!
  def index
    current_profile.save_wepay_auth_code params[:code]
    initialize_wepay_access_token(params[:code])

    redirect_to purchase_checkout_index_path
  end
end