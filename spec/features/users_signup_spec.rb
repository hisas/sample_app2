require "rails_helper"

describe "test sign up", type: :feature do
  before do
    ActionMailer::Base.deliveries.clear
  end

  it "should test invalid signup information" do
    visit signup_path
    expect {
      fill_in "Name", with: ""
      fill_in "Email", with: "user@invalid"
      fill_in "Password", with: "foo"
      fill_in "Confirmation", with: "bar"
      click_on "Create my account"
    }.to change { User.count }.by(0)
  end

  it "should test valid signup information" do
    visit signup_path
    expect {
      fill_in "Name", with: "Example User"
      fill_in "Email", with: "user@example.com"
      fill_in "Password", with: "password"
      fill_in "Confirmation", with: "password"
      click_on "Create my account"
    }.to change { User.count }.by(1)
    expect(ActionMailer::Base.deliveries.size).to eq 1
    user = create(:lana)
    expect(user.activated?).not_to eq true
    log_in_as(user)
    expect(page).to have_link "Log in", href: login_path
    visit edit_account_activation_path("invalid token", email: user.email)
    expect(page).to have_link "Log in", href: login_path
    visit edit_account_activation_path(user.activation_token, email: "wrong")
    expect(page).to have_link "Log in", href: login_path
    visit edit_account_activation_path(user.activation_token, email: user.email)
    expect(user.reload.activated?).to eq true
    expect(page).not_to have_link "Log in", href: login_path
  end
end
