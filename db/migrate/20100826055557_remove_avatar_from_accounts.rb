class RemoveAvatarFromAccounts < ActiveRecord::Migration
  def self.up
    remove_column :accounts, :avatar_updated_at
    remove_column :accounts, :avatar_file_size
    remove_column :accounts, :avatar_content_type
    remove_column :accounts, :avatar_file_name
  end

  def self.down
    add_column :accounts, :avatar_file_name, :string
    add_column :accounts, :avatar_content_type, :string
    add_column :accounts, :avatar_file_size, :integer
    add_column :accounts, :avatar_updated_at, :datetime
  end
end
