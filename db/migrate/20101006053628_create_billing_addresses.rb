class CreateBillingAddresses < ActiveRecord::Migration
  def self.up
    create_table :billing_addresses do |t|
      t.integer :account_id

      t.timestamps
    end
  end

  def self.down
    drop_table :billing_addresses
  end
end
