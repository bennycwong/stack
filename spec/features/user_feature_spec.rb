require 'rails_helper'

feature "Users Page Features" do
	before :each do
    DatabaseCleaner.clean
    visit root_url
    click_link "Sign in with Twitter"
    visit '/user/bwong337'
  end
  after :each do
    DatabaseCleaner.clean
  end

  scenario "User clicks on the first tweet username" do
    find(:xpath, '//a[@id="nickname-0"]').click
    expect(page).to have_selector("#user-page")
  end

  scenario "User clicks on the first tweet body hashtag" do
    first(:xpath, '//a[@class="tweet-hashtag"]').click
    expect(page).to have_selector("#overview-page")    
  end

  scenario "User clicks on the first tweet body nickname" do
    first(:xpath, '//a[@class="tweet-screen-name"]').click
    expect(page).to have_selector("#user-page")
  end

  scenario "User with no tweets loads" do
    request = FactoryGirl.create(:request, :user_with_no_tweets)
    visit '/user/'+request.query
    expect(page).to have_selector("#user-page")
  end


end



