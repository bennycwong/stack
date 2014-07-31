require 'rails_helper'

RSpec.describe UserController, :type => :controller do

  before :each do
    DatabaseCleaner.clean
    controller.class.before_filter :is_user_session?
	end

	after :each do
    DatabaseCleaner.clean
	end
	
  describe "GET index" do
    it "returns redirect" do
      get :index
      expect(response).to redirect_to("/")
    end
  end

  describe "GET show" do
    it "returns show" do
    	controller.class.skip_before_filter :is_user_session?
      get :show, :id => "Search"
      expect(response).to render_template :show
    end
  end

end
