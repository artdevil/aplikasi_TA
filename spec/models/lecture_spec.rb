require 'spec_helper'

describe Lecture do
  before(:each) do
    @attr = {:NIP => "611090096", 
             :kode_dosen => "AGS", 
             :nama_dosen => "Adhiguna Utama Sabril",
             :password => "foobar",
             :password_confirmation => "foobar"}
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

  describe "password validation" do
    
    it "should require a password" do
      Lecture.new(@attr.merge(:password => "",:password_confirmation => "")).should_not be_valid
    end
    
    it "should require a matching password" do
      Lecture.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end
    
    it "should reject short password" do
      short = "a" * 5
      lecture_short_password = Lecture.new(@attr.merge(:password => short, :password_confirmation => short ))
      lecture_short_password.should_not be_valid
    end
    
    it "should reject long password" do
      long = "a" * 41
      lecture_long_password = Lecture.new(@attr.merge(:password => long, :password_confirmation => long ))
      lecture_long_password.should_not be_valid
    end
    
  end

  describe"password encryption" do
    before (:each) do
      @lecture = Lecture.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @lecture.should respond_to(:encrypted_password)
    end
    
    it "should set encrypted password" do
      @lecture.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do
      
      it "should be true if the password match" do
        @lecture.has_password?(@attr[:password]).should be_true
      end
      
      it "should be false if the password didn't match" do
        @lecture.has_password?("invalid").should_not be_true
      end
    end
  
    describe "authentification method" do
      it "should return nil on NIP/password missmatch" do
        wrong_password_user = Lecture.authenticate(@attr[:NIP],"wrongpass")
        wrong_password_user.should be_nil
      end
      it "should return nil for an NIP with no password" do
        nonexisted_user = Lecture.authenticate("11121221",@attr[:password])
        nonexisted_user.should be_nil
      end
      it "should return NIP and password match" do
        matching_user= Lecture.authenticate(@attr[:NIP],@attr[:password])
        matching_user.should == @lecture
      end
    end
    
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

