require 'rails_helper'

feature "Search Tweets" do
	before :each do
    DatabaseCleaner.clean
    visit root_url
    click_link "Sign in with Twitter"
  end
  after :each do
    DatabaseCleaner.clean
  end

  scenario "User searches for basic term" do
    find(:xpath, '//input[@class="search-bar"]').set("USMNT")
    click_button "Search"
    expect(page).to have_text("Search Term: USMNT")
  end

  scenario "User searches for hashtag term" do
    find(:xpath, '//input[@class="search-bar"]').set("#USMNT")
    click_button "Search"
    expect(page).to have_text("Search Term: #USMNT")
  end

  scenario "User searches for @user term" do
    find(:xpath, '//input[@class="search-bar"]').set("@bwong337")
    click_button "Search"
    expect(page).to have_text("Search Term: @bwong337")
  end

  scenario "User search blank goes to default" do
    click_button "Search"
    expect(page).to have_text("Search Term: StackSocial")
  end
end



