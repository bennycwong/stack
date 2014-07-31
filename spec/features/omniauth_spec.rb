require 'rails_helper'

feature "Omniauth Login" do
	before :each do
    DatabaseCleaner.clean
  end

  scenario "User goes without logging in" do
    visit root_url
    expect(page).to have_text("Sign in with Twitter")
  end

  scenario "User logs with twitter creates user inv" do
    visit root_url
    click_link "Sign in with Twitter"
    expect(User.first.uid).to eq("562620090")
    expect(User.first.name).to eq("Benny Wong")
    expect(User.first.image).to eq("http://pbs.twimg.com/profile_images/432007368608473088/eNZmFU6I.jpeg")
    expect(User.first.provider).to eq("twitter")
    expect(User.first.nickname).to eq("bwong337")
    expect(User.first.access_token).to eq("562620090-Y9TN9AMa6T9MXFuGmvQ0m0W1GzFgqrlyFYTpuOki")
    expect(User.first.access_token_secret).to eq("f8Vl2jHfe7zXwLPiUvvy4fn9P7h0VL5D3uO3u6OGfa9aZ")
  end
  scenario "User logs in redirects to overview page" do
    visit root_url
    click_link "Sign in with Twitter"
    expect(page).not_to have_text("Sign in with Twitter")
    expect(page).to have_text("Search Term: StackSocial")
  end
end



