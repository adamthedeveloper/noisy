class RemoveTypeColumnFromProductsTable < ActiveRecord::Migration
  def self.up
    remove_column :products, :type
  end

  def self.down
    add_column :products, :type, :string
  end
end
