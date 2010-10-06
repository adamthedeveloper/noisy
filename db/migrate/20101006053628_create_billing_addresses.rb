class CreateBillingAddresses < ActiveRecord::Migration
  def self.up
    create_table :billing_addresses do |t|
      t.integer :billing_addressable_id
      t.string  :billing_addressable_type
      t.timestamps
    end
  end

  def self.down
    drop_table :billing_addresses
  end
end
