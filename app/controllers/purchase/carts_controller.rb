class Purchase::CartsController < Purchase::PurchaseController
  before_filter :authenticate_account!
  before_filter :init_cart

  def show
  end

  def update
    product = Product.find(params[:product])
    @cart.add_product product, params[:qnty].to_i
    redirect_to :action => 'show'
  end

  def delete
    product = Product.find(params[:product])
    @cart.remove_product product, params[:qnty].to_i
    redirect_to :action => 'show'
  end

  private
  def init_cart
    @cart = current_account.cart
  end
end