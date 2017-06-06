require "rails_helper"

describe "users signup" do
  let!(:lana) { create(:lana) }

  before do
    ActionMailer::Base.deliveries.clear
    visit signup_path
  end

  it "should test invalid signup information" do
    expect {
      fill_in "user[name]", with: ""
      fill_in "user[email]", with: "user@invalid"
      fill_in "user[password]", with: "foo"
      fill_in "user[password_confirmation]", with: "bar"
      click_on "Create my account"
    }.to change { User.count }.by(0)
  end

  it "should test valid signup information" do
    expect {
      fill_in "user[name]", with: "Example User"
      fill_in "user[email]", with: "user@example.com"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      click_on "Create my account"
    }.to change { User.count }.by(1)
    expect(ActionMailer::Base.deliveries.size).to eq 1
    expect(lana.activated?).not_to be true
    log_in_as(lana)
    expect(page).to have_link "Log in", href: login_path
    visit edit_account_activation_path("invalid token", email: lana.email)
    expect(page).to have_link "Log in", href: login_path
    visit edit_account_activation_path(lana.activation_token, email: "wrong")
    expect(page).to have_link "Log in", href: login_path
    visit edit_account_activation_path(lana.activation_token, email: lana.email)
    expect(lana.reload.activated?).to be true
    expect(page).not_to have_link "Log in", href: login_path
  end
end
