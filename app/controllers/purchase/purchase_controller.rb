class Purchase::PurchaseController < ApplicationController
  include Wepay

  private
  def gateway
    @gateway ||= PaymentGateway.new
  end
end