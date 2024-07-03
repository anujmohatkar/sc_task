require 'rails_helper'

RSpec.describe User, type: :model do

  it 'is valid with valid attributes' do 
    user = User.new(email: "anuj@mail.com", password: "asd123qwe")
    expect(user).to be_valid
  end

  it 'is not valid without email' do
    user = User.new(password: "asd123qwe")
    expect(user).to_not be_valid
  end

  it 'is not valid without password' do
    user = User.new(email: "anuj@mail.com")
    expect(user).to_not be_valid
  end

  it 'is not valid if password is too short' do
    user = User.new(email: "anuj@mail.com", password: "asd")
    expect(user).to_not be_valid
  end
end
