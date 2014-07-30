require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

  describe "GET queries" do
    it "returns http success" do
      get :queries
      expect(response).to be_success
    end
  end

end
