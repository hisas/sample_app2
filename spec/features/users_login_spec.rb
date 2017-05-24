require "rails_helper"

describe "users login" do
  let!(:michael) { create(:michael) }

  before do
    visit login_path
  end

  it "should login with invalid information" do
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    click_button "Log in"
    expect(page).to have_content "Invalid email/password combination"
    visit root_path
    expect(page).not_to have_content "Invalid email/password combination"
  end

  it "should login with valid information followed by logout" do
    fill_in "Email", with: michael.email
    fill_in "Password", with: "password"
    click_button "Log in"
    expect(page).not_to have_link "Log in", href: login_path
    expect(page).to have_link "Log out", href: logout_path
    expect(page).to have_link "My timeline", href: user_path(michael)
    click_on "Log out"
    visit root_path
    expect(page).to have_link "Log in", href: login_path
    expect(page).not_to have_link "Log out", href: logout_path
    expect(page).not_to have_link "My timeline", href: user_path(michael)
  end

  it "login with remembering" do
    fill_in "Email", with: michael.email
    fill_in "Password", with: "password"
    check "Remember me on this computer"
    click_button "Log in"
    expect(get_me_the_cookie("remember_token")).not_to eq nil
  end

  it "login without remembering" do
    fill_in "Email", with: michael.email
    fill_in "Password", with: "password"
    click_button "Log in"
    expect(get_me_the_cookie("remember_token")).to eq nil
  end
end
