class Purchase::CreditsController < Purchase::PurchaseController
  before_filter :authenticate_account!

  def index
    @credit_tiers = Product.credit_tiers
    @cart = current_account.shopping_cart
  end
end