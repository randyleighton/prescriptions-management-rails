require 'rails_helper'

describe "drug authentication" do
  it "will not allow user to access drug page without being logged in" do
    visit '/'
    find('img#drug-main').click
    #another option for clicking the image link
    #find(:xpath, "//a[contains(@href,'/drugs')]").click
    expect(page).to have_content 'Log In'
  end

  it "will allow a user to access drug page if logged in" do
    user = User.create(name: 'nacho', password: 'testpassword')
    visit '/login'
    fill_in 'Name', with: 'nacho'
    fill_in 'Password', with: 'testpassword'
    click_button 'Log In'
    visit '/drugs'
    expect(page).to have_content 'Current Drugs:'
  end
end

describe "adding drugs" do
  it "allows user to create a new drug if all information is entered" do
    user = User.create(name: 'nacho', password: 'testpassword')
    visit '/login'
    fill_in 'Name', with: 'nacho'
    fill_in 'Password', with: 'testpassword'
    click_button 'Log In'
    visit '/drugs'
    click_link 'New Drug'
    # another option for clicking new drug
    # find(:xpath, "//a[contains(@href,'/drugs/new')]").click
    fill_in 'Name', with: 'Norco'
    fill_in 'Description', with: 'Hydrocodone Generic for pain'
    fill_in 'Cost not in dh', with: '10'
    fill_in 'Cost in dh', with: '30'
    fill_in 'Bill to dh', with: '20'
    click_button 'Create Drug'
    expect(page).to have_content 'Norco created successfully'
  end

  it "will not allow a user to create a new drug if missing information" do
    user = User.create(name: 'nacho', password: 'testpassword')
    visit '/login'
    fill_in 'Name', with: 'nacho'
    fill_in 'Password', with: 'testpassword'
    click_button 'Log In'
    visit '/drugs'
    click_link 'New Drug'
    fill_in 'Description', with: 'Hydrocodone Generic for pain'
    fill_in 'Cost not in dh', with: '10'
    fill_in 'Cost in dh', with: '30'
    fill_in 'Bill to dh', with: '20'
    click_button 'Create Drug'
    expect(page).to have_content "Name can't be blank"
  end
end

describe "individual drugs" do
  it "views the information for an individual drug when a user clicks on it" do
    user = User.create(name: 'nacho', password: 'testpassword')
    visit '/login'
    fill_in 'Name', with: 'nacho'
    fill_in 'Password', with: 'testpassword'
    click_button 'Log In'
    visit '/drugs'
    click_link 'New Drug'
    fill_in 'Name', with: 'Norco'
    fill_in 'Description', with: 'Hydrocodone Generic for pain'
    fill_in 'Cost not in dh', with: '10'
    fill_in 'Cost in dh', with: '30'
    fill_in 'Bill to dh', with: '20'
    click_button 'Create Drug'
    click_link 'Norco'
    expect(page).to have_content 'Delete this drug'
  end

  it "deletes an individual drug when a user clicks on delete link" do
    user = User.create(name: 'nacho', password: 'testpassword')
    visit '/login'
    fill_in 'Name', with: 'nacho'
    fill_in 'Password', with: 'testpassword'
    click_button 'Log In'
    visit '/drugs'
    click_link 'New Drug'
    fill_in 'Name', with: 'Norco'
    fill_in 'Description', with: 'Hydrocodone Generic for pain'
    fill_in 'Cost not in dh', with: '10'
    fill_in 'Cost in dh', with: '30'
    fill_in 'Bill to dh', with: '20'
    click_button 'Create Drug'
    click_link 'Norco'
    click_link 'Delete this drug'
    expect(page).to have_content 'Current Drugs:'
  end
end





