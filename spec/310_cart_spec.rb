require 'spec_helper'
require 'account'

describe "Valid cart" do
  before :each do
    @cart = Cart.new
    @account = Account.make(:password => 'password')
  end

  it "should have an account" do
    @cart.should have(1).errors_on(:account)
    @cart.account = @account
    @cart.should have(:no).errors_on(:account)
  end

end

describe Cart do
  before :each do
    @account = Account.make(:password => 'password')
    @cart = Cart.new(:account => @account)
    @cart.save!
    @product = Product.make
  end

  it "should accept a new product" do
    @cart.add_product(@product)
    @cart.purchase_items.length.should == 1
    @cart.purchase_items.last.quantity.should == 1
  end

  it "should allow us to increase the quantity of a product" do
    @cart.add_product(@product)
    @cart.purchase_items.last.quantity.should == 1
    @cart.add_product(@product)
    @cart.purchase_items.reload.last.quantity.should == 2
  end

  it "should allow us to remove a product" do
    @cart.add_product(@product)
    @cart.purchase_items.length.should == 1
    @cart.purchase_items.last.quantity.should == 1
    @cart.remove_product(@product, 1)
    @cart.purchase_items.reload.last.quantity.should == 0
  end
end

describe "Non-empty cart" do
  before :each do
    @account = Account.make(:password => 'password')
    @cart = Cart.new(:account => @account)
    @cart.save!
    @cart.account = @account
    3.times { @cart.add_product(Product.make) }
  end

  it "should have an accurate subtotal" do
    @cart.subtotal.should == 15
  end

  it "should convert to an order and have a product associated as well as have the same subtotal the cart had" do
    @cart.purchase_items.count.should == 3
    @cart.convert_cart_to_order
    @cart.purchase_items.count.should == 0
    order = @account.orders.last
    order.purchase_items.count.should == 3
    order.subtotal.should == 15
  end

end