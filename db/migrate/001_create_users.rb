class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :password, :string
      t.column :bankroll, :integer
    end
    
    add_index :users, :password
  end

  def self.down
    drop_table :users
    delete_index :users, :password
  end
end
