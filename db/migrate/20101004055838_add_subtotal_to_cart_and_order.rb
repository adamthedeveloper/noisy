class AddSubtotalToCartAndOrder < ActiveRecord::Migration
  def self.up
    add_column :carts, :subtotal, :float, :default => 0
    add_column :orders, :subtotal, :float, :default => 0
  end

  def self.down
    remove_column :carts, :subtotal
    remove_column :orders, :subtotal
  end
end
