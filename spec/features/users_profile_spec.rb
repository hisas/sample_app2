require "rails_helper"
include ApplicationHelper

describe "users profile" do
  let!(:michael) { create(:michael) }

  before do
    30.times { michael.microposts.create(attributes_for(:micropost)) }
    log_in_as(michael)
    visit user_path(michael)
  end

  it "profile display" do
    expect(page).to have_title full_title(michael.name)
    expect(page).to have_selector "h1", text: michael.name
    expect(page).to have_selector "h1>img.gravatar"
    expect(page).to have_selector "h3", text: michael.microposts.count.to_s
    expect(page).to have_selector "nav.pagination"
  end
end
