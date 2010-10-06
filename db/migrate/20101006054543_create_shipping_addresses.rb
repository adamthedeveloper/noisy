class CreateShippingAddresses < ActiveRecord::Migration
  def self.up
    create_table :shipping_addresses do |t|
      t.integer :account_id

      t.timestamps
    end
  end

  def self.down
    drop_table :shipping_addresses
  end
end
