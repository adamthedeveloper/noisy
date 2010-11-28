class BillingAddress < ActiveRecord::Base
  has_one :address, :as => :addressable
  belongs_to :billing_addressable, :polymorphic => true
end
