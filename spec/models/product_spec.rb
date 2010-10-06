require 'spec_helper'
require 'account'

describe Product do
  before :each do
    @product = Product.new
  end

  it "must have a name" do
    @product.should have(1).errors_on(:name)
    @product.name = Faker::Lorem.words(5)
    @product.should have(:no).errors_on(:name)
  end

  it "must have a description" do
    @product.should have(1).errors_on(:description)
    @product.description = Faker::Lorem.paragraph
    @product.should have(:no).errors_on(:description)
  end

  it "must have a price" do
    @product.should have(1).errors_on(:price)
    @product.price = 5
    @product.should have(:no).errors_on(:price)
  end

  it "may or may not have a credit value" do
    @product.credit_value = nil
    @product.should have(:no).errors_on(:credit_value)
    @product.credit_value = 5
    @product.should have(:no).errors_on(:credit_value)
  end
end