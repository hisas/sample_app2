require "rails_helper"

describe "test login", type: :feature do
  before do
    @user = create(:michael)
  end

  it "should login with invalid information" do
    visit login_path
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    click_button "Log in"
    expect(page).to have_content "Invalid email/password combination"
    visit root_path
    expect(page).not_to have_content "Invalid email/password combination"
  end

  it "should login with valid information followed by logout" do
    visit login_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: "password"
    click_button "Log in"
    expect(page).not_to have_link "Log in", href: login_path
    expect(page).to have_link "Log out", href: logout_path
    expect(page).to have_link "Profile", href: user_path(@user)
    click_on "Log out"
    visit root_path
    expect(page).to have_link "Log in", href: login_path
    expect(page).not_to have_link "Log out", href: logout_path
    expect(page).not_to have_link "Profile", href: user_path(@user)
  end

  it "login with remembering" do
    visit login_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: "password"
    check "Remember me on this computer"
    click_button "Log in"
    expect(get_me_the_cookie("remember_token")).not_to eq nil
  end

  it "login without remembering" do
    visit login_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: "password"
    click_button "Log in"
    expect(get_me_the_cookie("remember_token")).to eq nil
  end

end
