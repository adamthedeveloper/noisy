class AddAccountIdToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :account_id, :integer
  end

  def self.down
    remove_column :profiles, :account_id
  end
end
