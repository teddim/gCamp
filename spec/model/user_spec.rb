require 'rails_helper'

describe User do

  it "Requires a first name - Invalid Test" do
    @user = User.create(last_name:'Test',email:'t@t.com',password:'test')
    expect(@user).to be_invalid
  end

  it "Requires a last name - Invalid Test" do
    @user = User.create(first_name:'Tester',email:'t@t.com',password:'test')
    expect(@user).to be_invalid
  end

  it "Requires an email - Invalid Test" do
    @user = User.create(first_name:'Tester',last_name:'Test',password:'test')
    expect(@user).to be_invalid
  end

  it "Requires a unique email - Invalid Test" do
    User.create(first_name:'Tester1',last_name:'Test1',email: 't@t.com',password:'test')
    @user = User.create(first_name:'Tester2',last_name:'Test2',email: 't@t.com',password:'test')
    expect(@user).to be_invalid
  end

  it "Requires a first name, last name, and email - Valid Test" do
    @user = User.create(first_name:'Tester',last_name:'Test',email:'t@t.com',password:'test')
    expect(@user).to be_valid
  end
end
