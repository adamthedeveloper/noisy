class BillingAddress < ActiveRecord::Base
  has_many :addresses, :as => :addressable
  belongs_to :billing_addressable, :polymorphic => true
end
