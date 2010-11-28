class ShippingAddress < ActiveRecord::Base
  has_one :address, :as => :addressable
  belongs_to :shipping_addressable, :polymorphic => true
end
