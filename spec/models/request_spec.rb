require 'rails_helper'

RSpec.describe Request, :type => :model do
	before :each do
    DatabaseCleaner.clean
	end

  it "can be created"  do
  	# expect(FactoryGirl.create(:user)).to be_valid
  end

  it "is invalid without a nickname" do
  	# expect(FactoryGirl.build(:user, :no_nickname)).not_to be_valid
  end
  
end
