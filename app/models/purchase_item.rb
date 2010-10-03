class PurchaseItem < ActiveRecord::Base
  belongs_to :purchaseable, :polymorphic => true
  belongs_to :product
  validates_presence_of :product
end
