class OverviewController < ApplicationController
  before_filter :is_user_session?, only: [:show, :create, :index]

  def index
    #Defaults to Stack Social if no search is passed
    redirect_to :controller => 'overview', :action => 'show', :id => "StackSocial"
  end

  def show
    @overview = "active"
  	@search = params[:id] 
    if Request.recent_request("search", @search).cached.any?
      @request = Request.recent_request("search", @search).cached.first
    else
      @request = Request.new(:query_type => "search", :query => @search, :query_size => 20)
      @request.save
    end
    @tweets = @request.tweets  
  end

  #Post in form to handle search
  def create
    redirect_to :action => 'show', :id => params[:id] 
  end

end
