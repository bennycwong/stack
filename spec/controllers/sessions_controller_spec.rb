require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do
	it 'login with twitter' do
		login_with_oauth

	end
end

	def login_with_oauth
    visit "/auth/twitter"
    visit "/auth/twitter/callback"
  end