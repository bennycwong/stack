class UserController < ApplicationController
  before_filter :is_user_session?, only: [:index, :show]

  def index
    #redirect to self if no user is found
    redirect_to :controller => 'user', :action => 'show', :id => current_user.nickname
  end

  def show
      @user_page = "active"
      @user_id = params[:id] 
     

      if Request.cached_request("user_timeline", @user_id).any?
        @request = Request.cached_request("user_timeline", @user_id).first
      else
        @request = Request.new(:query_type => "user_timeline", :query => @user_id, :query_size => 20)
        @request.save
      end

      @tweets = @request.user_timeline
      @user = get_user_info(@tweets)

  end

private

  def get_user_info(tweets)
    begin 
      tweets[0].user
    rescue
      #In the rare case that there is a user but they have no posts
        if Request.cached_request("user", @user_id).cached.any?
          userRequest = Request.cached_request("user", @user_id).cached.first
        else
          userRequest = Request.new(:query_type => "user", :query => @user_id)
          userRequest.save
        end
      userRequest.user_info
    end
  end
      

end
