require 'rails_helper'

describe "test static_pages_controller", type: :feature do
  it "should get home" do
    visit '/static_pages/home'
    expect(page).to have_http_status(:success)
    expect(page).to have_title('Home | Ruby on Rails Tutorial Sample App')
  end

  it "should get help" do
    visit '/static_pages/help'
    expect(page).to have_http_status(:success)
    expect(page).to have_title('Help | Ruby on Rails Tutorial Sample App')
  end

  it "should get about" do
    visit '/static_pages/about'
    expect(page).to have_http_status(:success)
    expect(page).to have_title('About | Ruby on Rails Tutorial Sample App')
  end
end
