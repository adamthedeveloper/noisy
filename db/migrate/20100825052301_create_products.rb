class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.integer :credit_value, :default => nil
      t.string :kind, :default => 'Credit'

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
