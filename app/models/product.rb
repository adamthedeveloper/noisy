class Product < ActiveRecord::Base
  validates_presence_of :name, :description, :price
  validates_presence_of :credit_value
end
