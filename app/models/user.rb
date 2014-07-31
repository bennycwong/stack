class User < ActiveRecord::Base
	has_many :queries
	validates :nickname ,presence: true
	validates :uid, uniqueness: true
	def self.create_with_omniauth(auth)
		create! do |user|
			user.provider = auth["provider"]
			user.uid = auth["uid"]
			user.name = auth["info"]["name"]
			user.access_token = auth["credentials"]["token"]
			user.access_token_secret = auth["credentials"]["secret"]
			user.nickname = auth["info"]["nickname"]
			user.image = auth["info"]["image"].gsub("_normal","")
		end
	end
end
