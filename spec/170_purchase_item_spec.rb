require 'spec_helper'

describe PurchaseItem do
  before :all do
    @product = Product.make
    @purchase_item = PurchaseItem.new
  end

  it "should have product" do
    @purchase_item.should have(1).errors_on(:product)
    @purchase_item.product = @product
    @purchase_item.should have(:no).errors_on(:product)
  end
end