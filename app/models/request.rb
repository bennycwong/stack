class Request < ActiveRecord::Base
	
	scope :cached, lambda { where('created_at > ?', Time.now - 5.minutes) }

	def self.recent_request(query_type, query)
    	self.where(:query_type => query_type, :query => query)

  	end

  def user_info
  	twitter = $client
  	if self.query_type == "user"
			user = twitter.user(self.query)
		end
		
		Rails.cache.fetch("request_cache: #{self.query}/user_info", :expires_in => 5.minutes) do 
			user
		end
  end
	
	def tweets
		twitter = $client
		
		if self.query_type == "search"
			tweet = twitter.search(self.query, :result_type => "recent")
		
		elsif self.query_type == "user_timeline"
			tweet = twitter.user_timeline(self.query, :result_type => "recent") 
		end
		
		Rails.cache.fetch("request_cache: #{self.query}/tweets", :expires_in => 5.minutes) do 
			tweet.to_a
		end
end


end
