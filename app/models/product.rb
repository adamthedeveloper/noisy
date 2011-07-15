class Product < ActiveRecord::Base
  validates_presence_of :name, :description, :price

  scope :credit_tiers, :conditions => {:kind => 'credit'}, :order => :price

end
