class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.text :description
      t.float :price
      t.integer :credit_value, :default => 0
      t.string :type, :default => 'Credit'

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
