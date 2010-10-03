class Cart < ActiveRecord::Base
  has_many :purchase_items, :as => :purchaseable
  belongs_to :account
  validates_presence_of :account

  def convert_cart_to_order
    account = self.account
    account.orders.build(:total => 0).save!
    order = account.orders.last
    self.purchase_items.each do |item|
      order.purchase_items.build(:product => item.product)
      order.save!
      item.delete
    end
    self.delete
  end
end
