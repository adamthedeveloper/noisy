class CreateShippingAddresses < ActiveRecord::Migration
  def self.up
    create_table :shipping_addresses do |t|
      t.integer :shipping_addressable_id
      t.string  :shipping_addressable_type
      t.timestamps
    end
  end

  def self.down
    drop_table :shipping_addresses
  end
end
