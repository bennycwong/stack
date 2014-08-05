class Request < ActiveRecord::Base
	validates :query_type ,presence: true
	validates :query ,presence: true
	before_save :default

	scope :cached, -> {  where('created_at > ?', Time.now - 5.minutes) }

	def default
	  self.query_size ||= 20
	end
	
	def self.cached_request(query_type, query)
		self.where(:query_type => query_type, :query => query).cached
	end

  def user_info
  	if self.query_type == "user"
			cache_api_call($twitter.user(self.query))
		end
  end

	def user_timeline
		if self.query_type == "user_timeline"
			cache_api_call($twitter.user_timeline(self.query, :result_type => "recent").take(self.query_size))
		end
	end
	
	def tweets
		if self.query_type == "search"
			cache_api_call($twitter.search(self.query, :result_type => "recent").take(self.query_size))
		end
	end

	private

	def cache_api_call(obj)
	Rails.cache.fetch("request_cache: #{id}/#{self.query}/tweets", :expires_in => 5.minutes) do 
			obj
		end
	end

end
