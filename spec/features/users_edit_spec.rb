require "rails_helper"

describe "users edit", type: :feature do
  let!(:michael) { create(:michael) }

  before do
    log_in_as(michael)
  end

  it "unsuccessful edit" do
    visit edit_user_path(michael)
    fill_in "Name", with: ""
    fill_in "Email", with: "foo@invalid"
    fill_in "Password", with: "foo"
    fill_in "Confirmation", with: "bar"
    click_on "Save changes"
    expect(current_path).to eq(user_path(michael))
  end

  it "successful edit with friendly forwarding" do
    visit edit_user_path(michael)
    fill_in "Name", with: "Foo Bar"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: ""
    fill_in "Confirmation", with: ""
    click_on "Save changes"
    expect(page).to have_content "Profile updated"
    michael.reload
    expect(michael.name).to have_content "Foo Bar"
    expect(michael.email).to have_content "foo@bar.com"
  end
end
