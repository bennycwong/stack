class SessionsController < ApplicationController
	def create
		auth = request.env["omniauth.auth"]
		user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
		session[:user_id] = user.id
		# raise auth.to_yaml
		#Redirect to dashboard
		redirect_to :controller => 'overview', :action => 'index', :notice => "Signed in!"
	end

	def destroy
  	session[:user_id] = nil
  	redirect_to root_url, :notice => "Signed out!"
	end
end
