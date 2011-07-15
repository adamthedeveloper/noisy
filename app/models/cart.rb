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

    self.billing_address.update_attributes(:billing_addressable => order)
    self.shipping_address.update_attributes(:shipping_addressable => order)

    order.save!

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
    self.subtotal = 0
    self.purchase_items.each { |item| self.subtotal += (item.quantity*item.product.price) }
    self.save!
  end

  def add_address(type = BILLING_ADDRESS, params = {})
    address = nil
    case type
      when BILLING_ADDRESS
        address = BillingAddress.new(:billing_addressable => self)
      when SHIPPING_ADDRESS
        address = ShippingAddress.new(:shipping_addressable => self)
    end

    if !address.nil?
      address.build_address(params)
      address.save!
      self.save!
    end
  end

  def grand_total
    # I am sure there will be more to add to this at some point
    subtotal
  end

end
