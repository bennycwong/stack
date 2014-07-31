class PagesController < ApplicationController
  before_filter :is_user_session?, only: [:queries]
  def queries
  	@queries = "active"
  	@requests = Request.find(:all, :order => "id desc", :limit => 1000)

  	respond_to do |format|
      format.html 
      format.json { render json: [:queries => @requests] }
    end
  end
end
