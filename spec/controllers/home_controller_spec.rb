require 'rails_helper'

RSpec.describe HomeController, :type => :controller do
	before :each do
    DatabaseCleaner.clean
	end

	after :each do
    DatabaseCleaner.clean
	end

  describe "GET index" do
    it "renders index" do
      get :index
      expect(response).to render_template :index
    end
  end

  

end
