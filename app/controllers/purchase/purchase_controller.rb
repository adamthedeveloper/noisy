include Wepay
class Purchase::PurchaseController < ApplicationController

  private
  def gateway
    @gateway ||= Wepay::PaymentGateway.new
  end
end