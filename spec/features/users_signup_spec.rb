require 'rails_helper'

describe "test sign up", type: :feature do

  it "should test invalid signup information" do
    visit signup_path
    user_count = User.count
    fill_in 'Name', with: ''
    fill_in 'Email', with: 'user@invalid'
    fill_in 'Password', with: 'foo'
    fill_in 'Confirmation', with: 'bar'
    click_on 'Create my account'
    expect(User.count).to eq(user_count)
  end

  it "should test valid signup information" do
    visit signup_path
    user_count = User.count
    fill_in 'Name', with: 'Example User'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Confirmation', with: 'password'
    click_on 'Create my account'
    expect(User.count).to eq(user_count + 1)
    expect(page).to have_content 'Welcome to the Sample App!'
    expect(page).not_to have_link 'Log in', href: login_path
    expect(page).to have_link 'Log out', href: logout_path
  end
end
