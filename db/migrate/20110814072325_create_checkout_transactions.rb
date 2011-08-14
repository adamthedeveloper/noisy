class CreateCheckoutTransactions < ActiveRecord::Migration
  def self.up
    create_table :checkout_transactions do |t|
      t.string :unique_token
      t.integer :cart_id
      t.string :status
      t.text :response

      t.timestamps
    end

    add_index :checkout_transactions, :cart_id
    add_index :checkout_transactions, :unique_token
  end

  def self.down
    drop_table :checkout_transactions
  end
end
