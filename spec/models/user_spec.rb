require 'rails_helper'

describe User do
  describe '#set_encrypted_password' do
    it "sets the password to an encrypted password" do
      user = User.new(password: '123abc')
      user.set_encrypted_password
      expect(user.encrypted_password).to eq('123abc') # This works because BCrypt overrides ==
    end

    it "removes the employee's password" do
      user = User.new(password: '123abc')
      user.set_encrypted_password
      expect(user.password).to be_nil
    end
  end

  describe '#authenticate' do
    before do
      @user = User.new(password: '123abc')
    end

    it "returns true when encrypted_password == the password argument" do
      @user.set_encrypted_password
      expect(@user.authenticate('123abc')).to eq(true)
    end

    it "returns false when encrypted_password != the password argument" do
      @user.set_encrypted_password
      expect(@user.authenticate('zyx987')).to eq(false)
    end

    it "returns false when no password is given" do
      @user.set_encrypted_password
      expect(@user.authenticate('')).to eq(false)
    end
  end
end