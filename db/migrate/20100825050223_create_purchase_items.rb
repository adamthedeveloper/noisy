class CreatePurchaseItems < ActiveRecord::Migration
  def self.up
    create_table :purchase_items do |t|
      t.integer :purchaseable_id
      t.string :purchaseable_type, :default => 'Cart'
      t.integer :account_id
      t.integer :product_id

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_items
  end
end
