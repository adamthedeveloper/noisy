class ModifyProductsCreditValueColumnRemoveDefault < ActiveRecord::Migration
  def self.up
    change_column :products, :credit_value, :integer, :default => nil
  end

  def self.down
    change_column :products, :credit_value, :integer, :default => 0
  end
end
