require "rails_helper"
include ApplicationHelper

describe "users profile", type: :feature do
  before do
    @user = create(:michael)
    30.times { @user.microposts.create(attributes_for(:micropost)) }
  end

  it "profile display" do
    visit user_path(@user)
    expect(page).to have_title full_title(@user.name)
    expect(page).to have_selector "h1", text: @user.name
    expect(page).to have_selector "h1>img.gravatar"
    expect(page).to have_selector "h3", text: @user.microposts.count.to_s
    expect(page).to have_selector "nav.pagination"
  end
end
