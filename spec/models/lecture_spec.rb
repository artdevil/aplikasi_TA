require 'spec_helper'

describe Lecture do
  before(:each) do
    @attr = {:NIP => "611090096", :kode_dosen => "AGS", :nama_dosen => "Adhiguna Utama Sabril"}
  end
  
  it "should create a new instance given valid attributes" do
    Lecture.new(@attr)
  end
  
  it "should require a NIP" do
    no_NIP = Lecture.new(@attr.merge(:NIP => ""))
    no_NIP.should_not be_valid
  end
  
  it "should require a kode dosen" do
    no_kode_dosen = Lecture.new(@attr.merge(:kode_dosen => ""))
    no_kode_dosen.should_not be_valid
  end
  
  it "should require a nama dosen" do
    no_nama_dosen = Lecture.new(@attr.merge(:nama_dosen => ""))
    no_nama_dosen.should_not be_valid
  end

  it "should reject too long NIP" do
    long_NIP = "a" * 12
    long_NIP_user = Lecture.new(@attr.merge(:NIP => long_NIP))
    long_NIP_user.should_not be_valid
  end
  
  it "should reject too long kode dosen" do
    long_kode = "a" * 4
    long_kode_dosen_user = Lecture.new(@attr.merge(:kode_dosen => long_kode))
    long_kode_dosen_user.should_not be_valid
  end
  
  it "should reject too long nama dosen" do
    long_nama = "a" * 101
    long_nama_dosen_user = Lecture.new(@attr.merge(:nama_dosen => long_nama))
    long_nama_dosen_user.should_not be_valid
  end
  
  it "should reject duplicate NIP" do
    Lecture.create!(@attr)
    user_with_duplicate_NIP = Lecture.new(@attr)
    user_with_duplicate_NIP.should_not be_valid
  end
  
  it "should reject duplicate kode dosen" do
    Lecture.create!(@attr)
    user_with_duplicate_kode_dosen = Lecture.new(@attr)
    user_with_duplicate_kode_dosen.should_not be_valid
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

