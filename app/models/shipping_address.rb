class ShippingAddress < ActiveRecord::Base
  has_many :addresses, :as => :addressable
  belongs_to :shipping_addressable, :polymorphic => true
end
