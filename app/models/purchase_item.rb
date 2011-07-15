class PurchaseItem < ActiveRecord::Base
  belongs_to :purchaseable, :polymorphic => true
  belongs_to :product
  validates_presence_of :product

  scope :with_product, lambda { |product| { :conditions => ['product_id = ?', product] } }

  def line_total
    quantity*product.price
  end
end
