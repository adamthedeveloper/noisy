class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.text :bio
      t.string :city
      t.string :state
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      t.string :occupation
      t.string :company
      t.string :website

      t.timestamps
    end
  end

  def self.down
    drop_table :profiles
  end
end
