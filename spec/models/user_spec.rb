require 'rails_helper'

RSpec.describe User, type: :model do
  describe Product do

    it "must be created with 'password' and 'password_confirmation' fields" do
      @user = User.create(
        :first_name => "Bob",
        :last_name => "Doe",
        :email => "testemail@gmail.com",
        :password => "123",
        :password_confirmation => '123'
      )
      expect(@user.id).not_to  be nil
    end

    it "does not save if  'password' and 'password_confirmation' fields are different" do
      @user = User.create(
        :first_name => "Bob",
        :last_name => "Doe",
        :email => "testemail@gmail.com",
        :password => "123",
        :password_confirmation => '11'
      )
      @error_message = @user.errors.full_messages
      expect(@error_message).to include("Password confirmation doesn't match Password")
    end

    it "does not save if  'password' field is blank" do
      @user = User.create(
        :first_name => "Bob",
        :last_name => "Doe",
        :email => "testemail@gmail.com",
        :password => nil,
        :password_confirmation => '11'
      )
      @error_message = @user.errors.full_messages
      expect(@error_message).to include("Password can't be blank")
    end

    it "does not save if  'password_confirmation' field is blank" do
      @user = User.create(
        :first_name => "Bob",
        :last_name => "Doe",
        :email => "testemail@gmail.com",
        :password => '123',
        :password_confirmation => nil
      )
      @error_message = @user.errors.full_messages
      expect(@error_message).to include("Password confirmation can't be blank")
    end

    it "does not create user with existing email" do
      @user = User.create!(
        :first_name => "Bob",
        :last_name => "Doe",
        :email => "testemail@gmail.com",
        :password => '123',
        :password_confirmation => '123'
      )

      @user1 = User.create(
        :first_name => "Bob",
        :last_name => "Doe",
        :email => "testemail@gmail.com",
        :password => '123',
        :password_confirmation => '123'
      )

      @error_message = @user1.errors.full_messages
      expect(@error_message).to include("Email has already been taken")
    end

    it "does not create user with existing email case insensitively" do
      @user = User.create!(
        :first_name => "Bob",
        :last_name => "Doe",
        :email => "Testemail@gmail.com",
        :password => '123',
        :password_confirmation => '123'
      )

      @user1 = User.create(
        :first_name => "Bob",
        :last_name => "Doe",
        :email => "tEstemail@gmail.Com",
        :password => '123',
        :password_confirmation => '123'
      )

      @error_message = @user1.errors.full_messages
      expect(@error_message).to include("Email has already been taken")
    end

    it "does not save if  'email' field is blank" do
      @user = User.create(
        :first_name => "Bob",
        :last_name => "Doe",
        :email => nil,
        :password => '123',
        :password_confirmation => '123'
      )
       @error_message = @user.errors.full_messages
      expect(@error_message).to include("Email can't be blank")
    end

    it "does not save if  'first_name' field is blank" do
      @user = User.create(
        :first_name => nil,
        :last_name => "Doe",
        :email => "testemail@gmail.com",
        :password => '123',
        :password_confirmation => '123'
      )
      @error_message = @user.errors.full_messages
      expect(@error_message).to include("First name can't be blank")
    end

    it "does not save if  'last_name' field is blank" do
      @user = User.create(
        :first_name => "Bob",
        :last_name => nil,
        :email => "testemail@gmail.com",
        :password => '123',
        :password_confirmation => '123'
      )
      @error_message = @user.errors.full_messages
      expect(@error_message).to include("Last name can't be blank")
    end

    it "password must me more than 2 symbols" do
      @user = User.create(
        :first_name => "Bob",
        :last_name => "Doe",
        :email => "Testemail@gmail.com",
        :password => '12',
        :password_confirmation => '12'
      )

      @error_message = @user.errors.full_messages
      expect(@error_message).to include("Password is too short (minimum is 3 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    it "authenticates with correct credentials" do 
      User.create(
        :first_name => "Bob",
        :last_name => "Doe",
        :email => "testemail@gmail.com",
        :password => '123',
        :password_confirmation => '123'
      )

      expect(User.authenticate_with_credentials "testemail@gmail.com", '123').not_to be nil
    end

    it "returns nil with incorrect credentials" do 
      User.create(
        :first_name => "Bob",
        :last_name => "Doe",
        :email => "testemail@gmail.com",
        :password => '123',
        :password_confirmation => '123'
      )
      expect(User.authenticate_with_credentials "testemail@gmail.com", '124').to be nil
    end

    it "authenticates with wrong email case" do
      User.create(
        :first_name => "Bob",
        :last_name => "Doe",
        :email => "eXample@domain.COM",
        :password => '123',
        :password_confirmation => '123'
      )
      expect(User.authenticate_with_credentials("EXAMPLe@DOMAIN.CoM", '123')).not_to be nil
    end

    it "authenticates with extra whitespace" do 
      User.create(
        :first_name => "Bob",
        :last_name => "Doe",
        :email => "testemail@gmail.com",
        :password => '123',
        :password_confirmation => '123'
      )

      expect(User.authenticate_with_credentials "  testemail@gmail.com  ", '123').not_to be nil
    end
  end
end
