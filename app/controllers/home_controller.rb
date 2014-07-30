class HomeController < ApplicationController
  def index
  	
  	if current_user
  		redirect_to overview_path("USMNT")
  	end
  end
end
