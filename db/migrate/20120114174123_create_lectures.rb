class CreateLectures < ActiveRecord::Migration
  def self.up
    create_table :lectures do |t|
      t.string :NIP
      t.string :kode_dosen
      t.string :nama_dosen

      t.timestamps
    end
  end
  
  def self.down
    drop_table :lectures
  end
end
