class OverviewController < ApplicationController
  before_filter :is_user_session?, only: [:index, :show, :create]
  
  def index
    #Defaults to Stack Social if no search is passed
    redirect_to :controller => 'overview', :action => 'show', :id => "StackSocial"
  end

  def show
    @overview = "active"
  	@search = params[:id] 
    if Request.cached_request("search", @search).any?
      @request = Request.cached_request("search", @search).first
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
