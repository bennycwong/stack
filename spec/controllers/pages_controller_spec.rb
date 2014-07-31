require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

	before :each do
    DatabaseCleaner.clean
    controller.class.before_filter :is_user_session?
	end

	after :each do
    DatabaseCleaner.clean
	end
	
  describe "GET queries" do
  	it "redirects if not logged in" do
      get :queries
      expect(response).to redirect_to("/")
    end

    it "returns queries page" do	
    	controller.class.skip_before_filter :is_user_session?
      get :queries
      expect(response).to render_template :queries
    end

    
    
end

end
