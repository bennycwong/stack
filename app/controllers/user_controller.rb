class UserController < ApplicationController
  before_filter :is_user_session?, only: [:index, :show]

  def index
    redirect_to :controller => 'user', :action => 'show', :id => current_user.nickname
  end

  def show
    puts @user_id = params[:id] 
    #begin
      @tweets = []
      @user = []

      if Request.recent_request("user", @user_id).cached.any?
        @userRequest = Request.recent_request("user", @user_id).cached.first
      else
        @userRequest = Request.new(:query_type => "user", :query => @user_id)
        @userRequest.save
      end

      if Request.recent_request("user_timeline", @user_id).cached.any?
        @request = Request.recent_request("user_timeline", @user_id).cached.first
      else
        @request = Request.new(:query_type => "user_timeline", :query => @user_id)
        @request.save
      end
      

      @user = @userRequest.user_info 
      @request.tweets.take(20).each do |tweet|
        @tweets << tweet
      end

      respond_to do |format|
        format.html 
        format.json { render json: [:tweets => @tweets, :user => @user] }
      end

    #rescue
   #   redirect_to user_path, notice: "Could not find user @" + @user_id + ". Redirected to user page."
   # end
  end
end
