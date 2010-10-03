class Order < ActiveRecord::Base
  has_many :purchase_items, :as => :purchaseable
  belongs_to :account
  validates_presence_of :account
end
