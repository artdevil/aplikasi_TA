class Lecture < ActiveRecord::Base
  attr_accessible :NIP, :kode_dosen, :nama_dosen
  
  validates :NIP, :presence => true,
                  :length => {:maximum => 11},
                  :uniqueness => true
  validates :kode_dosen, :presence => true,
                  :length => {:maximum => 3},
                  :uniqueness => true
  validates :nama_dosen, :presence => true,
                         :length => {:maximum => 100}
end

# == Schema Information
#
# Table name: lectures
#
#  id         :integer         not null, primary key
#  NIP        :string(255)
#  kode_dosen :string(255)
#  nama_dosen :string(255)
#  created_at :datetime
#  updated_at :datetime
#

