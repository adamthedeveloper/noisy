class PurchaseItem < ActiveRecord::Base
  belongs_to :purchaseable, :polymorphic => true
  belongs_to :product
end
