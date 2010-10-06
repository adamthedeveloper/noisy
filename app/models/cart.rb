class Cart < ActiveRecord::Base
  has_many :purchase_items, :as => :purchaseable
  has_one :shipping_address, :as => :shipping_addressable
  has_one :billing_address, :as => :billing_addressable
  belongs_to :account
  validates_presence_of :account

  BILLING_ADDRESS = 'billing'
  SHIPPING_ADDRESS = 'shipping'

  def convert_cart_to_order
    self.account.orders.build(
            :total => 0,
            :subtotal => self.subtotal
    ).save!

    order = self.account.orders.last

    self.purchase_items.each do |item|
      order.purchase_items.build(:product => item.product)
      order.save!
      item.delete
    end

    self.delete
  end

  def add_product(product, quantity = 1)
    purchase_item = self.purchase_items.with_product(product).last
    if purchase_item.nil?
      self.purchase_items.build(:product => product)
      self.save
      purchase_item = self.purchase_items.last
    end
    purchase_item.quantity += quantity
    purchase_item.save!
    reset_subtotal
    self
  end

  def remove_product(product, quantity = 1)
    purchase_item = self.purchase_items.with_product(product).last
    return self if purchase_item.nil?
    purchase_item.quantity -= quantity
    purchase_item.save!
    reset_subtotal
    self
  end

  def reset_subtotal
    subtotal = 0
    self.purchase_items.each { |item| subtotal += (item.quantity*item.product.price) }
    self.subtotal = subtotal
    self.save!
  end

  def add_address(type = BILLING_ADDRESS, params = {})
    case type
      when BILLING_ADDRESS
        self.billing_address = BillingAddress.new(Address.new(params))
      when SHIPPING_ADDRESS
        self.shipping_address = ShippingAddress.new(Address.new(params))
    end
    self.save!
  end

end
