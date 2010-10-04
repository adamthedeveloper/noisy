class AddColumnQuantityToTablePurchaseItems < ActiveRecord::Migration
  def self.up
    add_column :purchase_items, :quantity, :integer
  end

  def self.down
    remove_column :purchase_items, :quantity
  end
end
