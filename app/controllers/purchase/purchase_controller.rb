include Wepay
class Purchase::PurchaseController < ApplicationController

  private
  def gateway
    @gateway ||= PaymentGateway.new
  end
end