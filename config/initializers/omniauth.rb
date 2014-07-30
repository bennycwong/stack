TWITTER_CONFIG = YAML.load_file("#{::Rails.root}/config/twitter.yml")[::Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end