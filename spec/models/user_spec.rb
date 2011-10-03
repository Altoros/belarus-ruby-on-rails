require 'spec_helper'

describe User do
  it "should create a new instance given a valid attribute" do
    User.delete_all
    Factory(:user)

    User.all.should have(1).item
  end
  
  it "should require an email address" do
    no_email_user = Factory.build(:user, :email => "")
    no_email_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = Factory.build(:user, :email => address)
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = Factory.build(:user, :email => address)
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    @user = Factory(:user)
    user_with_duplicate_email = Factory.build(:user, :email => @user.email)
    user_with_duplicate_email.should_not be_valid
  end
  
  it "should reject email addresses identical up to case" do
    @user = Factory(:user)
    user_with_duplicate_email = Factory.build(:user, :email => @user.email.upcase)
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "passwords" do
    before(:each) do
      @user = Factory.build(:user)
    end

    it "should have a password attribute" do
      @user.should respond_to(:password)
    end

    it "should have a password confirmation attribute" do
      @user.should respond_to(:password_confirmation)
    end
  end
  
  describe "password validations" do
    it "should require a password" do
      user = Factory.build(:user, :password => "", :password_confirmation => "")
      user.should_not be_valid
    end

    it "should require a matching password confirmation" do
      user = Factory.build(:user, :password_confirmation => "invalid")
      user.should_not be_valid
    end
    
    it "should reject short passwords" do
      password = "a" * 5
      user = Factory.build(:user, :password => password, :password_confirmation => password)
      user.should_not be_valid
    end
  end
  
  describe "password encryption" do
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password attribute" do
      @user.encrypted_password.should_not be_blank
    end
  end 
end
