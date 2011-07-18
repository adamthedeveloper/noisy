class Purchase::PurchaseController < ApplicationController
  include WepayRails::Payments
end