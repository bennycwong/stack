require 'rails_helper'

feature "Header Features" do
	before :each do
    DatabaseCleaner.clean
    visit root_url
    click_link "Sign in with Twitter"
  end
  after :each do
    DatabaseCleaner.clean
  end

  scenario "User clicks on TweetReader when on Overview Page " do
    find(:xpath, '//a[@class="navbar-brand"]').click
    expect(page).to have_selector("#overview-page")
  end
  
  scenario "User clicks on TweetReader when on User Page " do
    visit user_path("bwong337")
    find(:xpath, '//a[@class="navbar-brand"]').click
    expect(page).to have_selector("#user-page")
  end

  scenario "User clicks on TweetReader when on Query Page " do
    visit queries_path
    find(:xpath, '//a[@class="navbar-brand"]').click
    expect(page).to have_selector("#queries-page")
  end

  scenario "User clicks on Overview" do
    visit user_path("bwong337")
    expect(page).not_to have_selector(:xpath, '//li[@class="active"]//a[@href="/overview"]') 
    find(:xpath, '//a[@href="/overview"]').click  
    expect(page).to have_selector(:xpath, '//li[@class="active"]//a[@href="/overview"]') 
    expect(page).to have_selector("#overview-page")

  end
  scenario "User clicks on User" do
    expect(page).not_to have_selector(:xpath, '//li[@class="active"]//a[@href="/user"]') 
    find(:xpath, '//li//a[@href="/user"]').click  
    expect(page).to have_selector(:xpath, '//li[@class="active"]//a[@href="/user"]') 
    expect(page).to have_selector("#user-page")
  end

  scenario "User clicks on Query" do
    expect(page).not_to have_selector(:xpath, '//li[@class="active"]//a[@href="/queries"]') 
    find(:xpath, '//a[@href="/queries"]').click  
    expect(page).to have_selector(:xpath, '//li[@class="active"]//a[@href="/queries"]') 
    expect(page).to have_selector("#queries-page")
  end

  scenario "User clicks on UserName" do
    expect(page).not_to have_selector(:xpath, '//li[@class="active"]//a[@href="/user"]') 
    find(:xpath, '//p[@class="navbar-text pull-right"]//a[@href="/user"]').click  
    expect(page).to have_selector(:xpath, '//li[@class="active"]//a[@href="/user"]') 
    expect(page).to have_selector("#user-page")
  end

  scenario "User clicks on Signout, user signs out" do
    expect(page).not_to have_selector(:xpath, '//li[@class="active"]//a[@href="/user"]') 
    find(:xpath, '//p[@class="navbar-text pull-right"]//a[@href="/signout"]').click  
    expect(page).not_to have_selector(:xpath, '//li[@class="active"]//a[@href="/user"]') 
    expect(page).to have_text("Sign in with Twitter")
    
  end




end



