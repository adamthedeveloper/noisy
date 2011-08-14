class Purchase::CheckoutController < Purchase::PurchaseController
  before_filter :authenticate_account!

  def index
    if current_profile.has_wepay_auth_code?
      if wepay_access_token_exists?

        cart = current_account.cart
        tx_id = cart.init_transaction

        checkout_params = {
            :amount => cart.grand_total,
            :short_description => cart.short_description,
            :long_description => cart.long_description,
            :callback_uri => purchase_finalize_index_url(:txID => tx_id)
        }

        init_checkout_and_send_user_to_wepay checkout_params
      else
        initialize_wepay_access_token(current_profile.wepay_auth_code)
      end
    else
      redirect_to_wepay_for_auth
    end
  end
end