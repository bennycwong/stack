require 'rails_helper'

RSpec.describe User, :type => :model do
	
	before :each do
    DatabaseCleaner.clean
	end
	after :each do
    DatabaseCleaner.clean
  end

  it "can be created"  do
  	expect(FactoryGirl.create(:user)).to be_valid
  end

  it "invalid without a nickname" do
  	expect(FactoryGirl.build(:user, :no_nickname)).not_to be_valid
  end

  it "must not have duplicate uids" do
  	FactoryGirl.create(:user)
  	expect(FactoryGirl.build(:user)).not_to be_valid
  end

	  
end
