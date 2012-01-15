require 'digest'
class Lecture < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :NIP, :kode_dosen, :nama_dosen, :password, :password_confirmation
  
  validates :NIP, :presence => true,
                  :length => {:maximum => 11},
                  :uniqueness => true
  validates :kode_dosen, :presence => true,
                  :length => {:maximum => 3},
                  :uniqueness => true
  validates :nama_dosen, :presence => true,
                         :length => {:maximum => 100}
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 6..40 }
                       
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  
  def self.authenticate(nip, submitted_password)
    lecture = find_by_NIP(nip)
    return nil if lecture.nil?
    return lecture if lecture.has_password?(submitted_password)
  end
  
  private
  
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end
  
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
    
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
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

