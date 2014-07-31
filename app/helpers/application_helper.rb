module ApplicationHelper

  include Twitter::Extractor

  def active_navigation(item)
    'active' if params[:controller] == item
  end
  
  def auto_link(tweet)
    screen_names = extract_mentioned_screen_names(tweet)
    urls = extract_urls(tweet)
    hash_tags = extract_hashtags(tweet)

    if screen_names != []
      screen_names.each do |s|
        link_to_user = "<a class='tweet-screen-name' href='/user/" + s + "'>@" + s + "</a>"
        tweet = tweet.gsub("@"+s, link_to_user)
      end
    end

    if urls != []
      urls.each do |u|
        link_to_url = "<a class='tweet-link' target='_blank' href='" + u + "'>" + u + "</a>"
        tweet = tweet.gsub(u, link_to_url)
      end
    end

    if hash_tags != []
      hash_tags.each do |h|
        link_to_hash = "<a class='tweet-hashtag' href='/overview/%23" + h + "'>#" + h + "</a>"
        tweet = tweet.gsub("#"+h, link_to_hash)
      end
    end

    tweet
  end

end
