require "rails_helper"

describe StaticPagesController do
  render_views

  it "should get home" do
    visit root_path
    expect(page).to have_http_status(:success)
    expect(page).to have_selector "title", exact_text: "Ruby on Rails Tutorial Sample App", visible: false
  end

  it "should get help" do
    visit help_path
    expect(page).to have_http_status(:success)
    expect(page).to have_selector "title", exact_text: "Help | Ruby on Rails Tutorial Sample App", visible: false
  end

  it "should get about" do
    visit about_path
    expect(page).to have_http_status(:success)
    expect(page).to have_selector "title", exact_text: "About | Ruby on Rails Tutorial Sample App", visible: false
  end

  it "should get contact" do
    visit contact_path
    expect(page).to have_http_status(:success)
    expect(page).to have_selector "title", exact_text: "Contact | Ruby on Rails Tutorial Sample App", visible: false
  end
end
