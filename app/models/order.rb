class Order < ActiveRecord::Base
  has_many :purchase_items, :as => :purchaseable
  belongs_to :account
  has_one :shipping_address, :as => :shipping_addressable
  has_one :billing_address, :as => :billing_addressable
  validates_presence_of :account
end
