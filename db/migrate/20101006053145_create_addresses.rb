class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :addressable_type
      t.integer :addressable_id
      t.string :first_name
      t.string :last_name
      t.string :street_1
      t.string :street_2
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :phone
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
