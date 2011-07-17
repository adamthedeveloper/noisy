class Purchase::PurchaseController < ApplicationController

  private
  include WepayRails::Payments
end