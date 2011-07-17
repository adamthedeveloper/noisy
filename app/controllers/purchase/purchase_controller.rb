class Purchase::PurchaseController < ApplicationController

  private

  include Wepay::Payments
end