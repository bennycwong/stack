require 'rails_helper'

feature "Query Features" do
	before :each do
    DatabaseCleaner.clean
    visit root_url
    click_link "Sign in with Twitter"
    find(:xpath, '//a[@href="/queries"]').click  
  end
  after :each do
    DatabaseCleaner.clean
  end

  scenario "Query is logged when initial log in" do
    expect(page.find(:xpath, '//td[@id="query-0"]')).to have_content("StackSocial")
  end

  scenario "Query is logged only once within 5 minutes" do
    query = FactoryGirl.create(:request,:search)
    expect(page.find(:xpath, '//td[@id="query-0"]')).to have_content("StackSocial")
    expect(page).not_to have_selector(:xpath, '//td[@id="query-1"]')
  end

  scenario "Query is logged again after 5 minutes" do
    request = FactoryGirl.create(:request, :created_at => Time.now-6.minutes)
    visit '/overview/bwong337'

    find(:xpath, '//a[@href="/queries"]').click  

    expect(page.find(:xpath, '//td[@id="query-0"]')).to have_content("bwong337")
    expect(page.find(:xpath, '//td[@id="query-1"]')).to have_content("bwong337")
  end

  scenario "Query is not logged again before 5 minutes" do
    request = FactoryGirl.create(:request, :created_at => Time.now-5.minutes+10)
    visit '/overview/bwong337'

    find(:xpath, '//a[@href="/queries"]').click  

    expect(page.find(:xpath, '//td[@id="query-0"]')).to have_content("bwong337")
    expect(page.find(:xpath, '//td[@id="query-1"]')).not_to have_content("bwong337")
  end
  




end



