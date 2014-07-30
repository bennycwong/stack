class OverviewController < ApplicationController
  before_filter :is_user_session?, only: [:show]
  def index
    redirect_to :controller => 'overview', :action => 'show', :id => "USMNT"
  end

  def show
  	@search = params[:id] 
  	@tweets = []
    if Request.recent_request("search", @search).cached.any?
      @request = Request.recent_request("search", @search).cached.first
    else

      @request = Request.new(:query_type => "search", :query => @search)
      @request.save
    end

    @request.tweets.take(20).each do |tweet|
      @tweets << tweet
    end

    respond_to do |format|
      format.html 
      format.json { render json: [:tweets => @tweets] }
    end
    
  end

  def create
    redirect_to :action => 'show', :id => params[:id] 
  end

end
