class Request < ActiveRecord::Base
	validates :query_type ,presence: true
	validates :query ,presence: true
	before_save :default

	def default
	  self.query_size ||= 20
	end

	scope :cached, -> {  where('created_at > ?', Time.now - 5.minutes) }
	
	def self.cached_request(query_type, query)
		self.where(:query_type => query_type, :query => query).cached
	end

  def user_info
  	twitter = $client
  	if self.query_type == "user"
			user = twitter.user(self.query)
			Rails.cache.fetch("request_cache: #{id}/#{self.query}/user_info", :expires_in => 5.minutes) do 
				user
			end
		end
  end

	def user_timeline
		twitter = $client
		if self.query_type == "user_timeline"
			timeline = twitter.user_timeline(self.query, :result_type => "recent").take(self.query_size)
			Rails.cache.fetch("request_cache: #{id}/#{self.query}/tweets", :expires_in => 5.minutes) do 
				timeline
			end
		end
	end
	
	def tweets
		twitter = $client
		if self.query_type == "search"
			tweet = twitter.search(self.query, :result_type => "recent").take(self.query_size)
			Rails.cache.fetch("request_cache: #{id}/#{self.query}/tweets", :expires_in => 5.minutes) do 
				tweet
			end
		end
	end

end
