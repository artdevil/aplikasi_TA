class AddSaltToLectures < ActiveRecord::Migration
  def self.up
    add_column :lectures, :salt, :string
  end
  
  def self.down
    remove_column :lectures, :salt
  end
end
