require 'rails_helper'

RSpec.describe Request, :type => :model do
	before :each do
    DatabaseCleaner.clean
	end
  after :each do
    DatabaseCleaner.clean
  end

  it "can be created"  do
  	expect(FactoryGirl.create(:request, :search)).to be_valid
  end

  it "must have query_size" do
  	expect(FactoryGirl.create(:request, :nil_size).query_size).to be(20)
  end

  it "must have integer as query_size" do
    expect(FactoryGirl.create(:request, :non_default_size).query_size).not_to be(20)
  end

  context "test matching requests" do
    before :each do
      @request = FactoryGirl.create(:request)
    end
    it "can find matched request" do 
      expect(Request.cached_request("search", "bwong337").first).to eq(@request)
    end

    it "won't find unmatched request" do 
      expect(Request.cached_request("search", "nottrue")).not_to eq(@request)
    end
  end

  it "won't find not requests more than 5 minutes" do 
    request = FactoryGirl.create(:request, :created_at => Time.now-5.minutes)
    expect(Request.cached_request("search", "bwong337")).not_to eq(request)
  end

  it "can find request that are less than 5 minutes" do 
    request = FactoryGirl.create(:request, :created_at => Time.now-5.minute+1)
    expect(Request.cached_request("search", "bwong337").first).to eq(request)
  end
  
end
