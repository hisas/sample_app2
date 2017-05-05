require "rails_helper"

describe "test users index", type: :feature do
  before do
    @michael = create(:michael)
    @archer = create(:archer)
    30.times { create(:user) }
  end

  it "index as admin including pagination and delete links" do
    log_in_as(@michael)
    visit users_path
    expect(page).to have_selector "nav.pagination"
    User.page(1).each do |user|
      expect(page).to have_link user.name, href: user_path(user)
      unless user == @michael
        expect(page).to have_link "delete", href: user_path(user)
      end
    end
    count = User.count
    page.driver.submit :delete, user_path(@archer), {}
    expect(User.count).to eq count - 1
  end

  it "index as non-admin" do
    log_in_as(@archer)
    visit users_path
    expect(page).not_to have_selector "a", text: "delete"
  end
end
