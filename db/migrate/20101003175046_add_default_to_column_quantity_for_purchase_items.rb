class AddDefaultToColumnQuantityForPurchaseItems < ActiveRecord::Migration
  def self.up
    change_column :purchase_items, :quantity, :integer, :default => 0
  end

  def self.down
    change_column :purchase_items, :quantity, :integer, :default => nil
  end
end
