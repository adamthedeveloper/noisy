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

describe "Empty cart" do
  before :each do
    @account = Account.make(:password => 'password')
    @cart = Cart.new(:account => @account)
    @cart.save!
  end

  it "should accept a product" do
    3.times { @cart.purchase_items.build :product => Product.make }
    @cart.save!
    @cart.purchase_items.length.should == 3
  end
end

describe "Non-empty cart" do
  before :each do
    @account = Account.make(:password => 'password')
    @cart = Cart.new(:account => @account)
    @cart.save!
    @cart.account = @account
    @cart.purchase_items.build(:product => Product.make).save!
  end

  it "should convert to an order and have a product associated" do
    @cart.purchase_items.count.should == 1
    @cart.convert_cart_to_order
    @cart.purchase_items.count.should == 0
    @account.orders.last.purchase_items.count.should == 1
  end
end