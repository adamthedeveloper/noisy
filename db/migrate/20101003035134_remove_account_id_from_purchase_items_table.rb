class RemoveAccountIdFromPurchaseItemsTable < ActiveRecord::Migration
  def self.up
    remove_column :purchase_items, :account_id
  end

  def self.down
    add_column :purchase_items, :account_id, :integer
  end
end
