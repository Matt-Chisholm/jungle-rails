require 'rails_helper'

RSpec.describe User, type: :model do

  
  describe 'Validations' do


    it 'is invalid if password' do
      @user = User.new(
        first_name:            "Test",
        last_name:             "User",
        email:                 "test@test.com",
        password:              nil,
        password_confirmation: "123"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'is invalid if password and confirmation dont match' do
      @user = User.new(
        first_name:            "Test",
        last_name:             "User",
        email:                 "test@test.com",
        password:              '234',
        password_confirmation: "123"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is invalid if email already exists' do
      @user2 = User.new(
        first_name:            "Test",
        last_name:             "User",
        email:                 "test@test.com",
        password:              '234',
        password_confirmation: "123"
      )
      @user = User.new(
        first_name:            "Test",
        last_name:             "User",
        email:                 "test@test.com",
        password:              '234',
        password_confirmation: "123"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'is invalid if first_name missing' do
      @user = User.new(
        first_name:            nil,
        last_name:             "User",
        email:                 "test@test.com",
        password:              "123",
        password_confirmation: "123"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end

    it 'is invalid if last_name missing' do
      @user = User.new(
        first_name:            "test",
        last_name:             nil,
        email:                 "test@test.com",
        password:              "123",
        password_confirmation: "123"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'is invalid if password too short' do
      @user = User.new(
        first_name:            "test",
        last_name:             "user",
        email:                 "test@test.com",
        password:              "12",
        password_confirmation: "12"
      )
      expect(@user).to be_invalid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end

  end

  describe '.authenticate_with_credentials' do
    it 'returns nil with nil email & pw' do
      expect(User.authenticate_with_credentials(nil, nil)).to eq(nil)
    end

    it 'returns nil with invalid email' do
      expect(User.authenticate_with_credentials('hello', 'nil')).to eq(nil)
    end

    it 'returns nil with nil email' do
      expect(User.authenticate_with_credentials(nil, 'nil')).to eq(nil)
    end

    it 'returns nil with nil pw' do
      expect(User.authenticate_with_credentials("Bob@bob.com", nil)).to eq(nil)
    end

    it 'returns a user with valid params' do
      User.new(
        first_name:            "test",
        last_name:             "user",
        email:                 "test@test.com",
        password:              "123",
        password_confirmation: "123"
      ).save
      @user = User.authenticate_with_credentials("test@test.com", "123")
      expect(@user.email).to eq("test@test.com")
    end

    it 'returns a user with valid params and trailing spaces' do
      User.new(
        first_name:            "test",
        last_name:             "user",
        email:                 "test@test.com",
        password:              "123",
        password_confirmation: "123"
      ).save
      @user = User.authenticate_with_credentials("  test@test.com  ", "123")
      expect(@user.email).to eq("test@test.com")
    end

    it 'returns a user with valid params random CAPS' do
      User.new(
        first_name:            "test",
        last_name:             "user",
        email:                 "test@test.com",
        password:              "123",
        password_confirmation: "123"
      ).save
      @user = User.authenticate_with_credentials("TeST@TESt.com", "123")
      expect(@user.email).to eq("test@test.com")
    end

  end


end
