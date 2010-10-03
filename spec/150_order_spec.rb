require 'spec_helper'
require 'account'

describe Order do
  before :each do
    @account = Account.make
    @order = Order.new
  end

  it "should always have an account" do
    @order.should have(1).errors_on(:account)
    @order.account = @account
    @order.should have(:no).errors_on(:account)
  end
end