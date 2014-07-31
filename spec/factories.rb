# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :requests do
    	query "bwong337"
    trait :cached_search do
    	query "bieber"
    	query_type "search"
    end
    
    trait :search do
    	query "USMNT"
    	query_type "search"
    end
    trait :user_timeline do

    	query_type "user_timeline"
    end
    trait :user_info do
    	query_type "user"
    end
	end
end


FactoryGirl.define do
  factory :user do
    uid		"562620090"
    name  	"Benny Wong"
    image 	"http://pbs.twimg.com/profile_images/432007368608473088/eNZmFU6I.jpeg"
    provider	"twitter"
    nickname	"bwong337"
    access_token "562620090-Y9TN9AMa6T9MXFuGmvQ0m0W1GzFgqrlyFYTpuOki"
    access_token_secret "f8Vl2jHfe7zXwLPiUvvy4fn9P7h0VL5D3uO3u6OGfa9aZ"
  end
  trait :no_nickname do
      nickname    nil
  end

end