class AddWepayAuthCodeToProfiles < ActiveRecord::Migration
  def self.up
    add_column :profiles, :wepay_auth_code, :string
  end

  def self.down
    remove_column :profiles, :wepay_auth_code
  end
end
