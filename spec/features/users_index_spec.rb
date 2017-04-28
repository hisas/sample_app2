require "rails_helper"

describe "test users index", type: :feature do
  before do
    30.times { create(:user) }
    @admin = create(:michael)
    @non_admin = create(:archer)
  end

  def log_in_as(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  it "index as admin including pagination and delete links" do
    log_in_as(@admin)
    visit users_path
    expect(page).to have_selector "nav.pagination"
    User.page(1).each do |user|
      expect(page).to have_link user.name, href: user_path(user)
      unless user == @admin
        expect(page).to have_link "delete", href: user_path(user)
      end
    end
    count = User.count
    page.driver.submit :delete, user_path(@non_admin), {}
    expect(User.count).to eq count - 1
  end

  it "index as non-admin" do
    log_in_as(@non_admin)
    visit users_path
    expect(page).not_to have_selector "a", text: "delete"
  end
end
