require "rails_helper"

describe "test users edit", type: :feature do
  before do
    @user = create(:michael)
  end

  it "unsuccessful edit" do
    log_in_as(@user)
    visit edit_user_path(@user)
    fill_in "Name", with: ""
    fill_in "Email", with: "foo@invalid"
    fill_in "Password", with: "foo"
    fill_in "Confirmation", with: "bar"
    click_on "Save changes"
    expect(current_path).to eq(user_path(@user))
  end

  it "successful edit with friendly forwarding" do
    visit edit_user_path(@user)
    log_in_as(@user)
    expect(current_path).to eq(edit_user_path(@user))
    fill_in "Name", with: "Foo Bar"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: ""
    fill_in "Confirmation", with: ""
    click_on "Save changes"
    expect(page).to have_content "Profile updated"
    @user.reload
    expect(@user.name).to have_content "Foo Bar"
    expect(@user.email).to have_content "foo@bar.com"
  end
end
