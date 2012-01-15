class AddPasswordToLectures < ActiveRecord::Migration
  def self.up
    add_column :lectures, :encrypted_password, :string
  end
  
  def self.down
    remove_colomn :lectures, :encrypted_password
  end
end
