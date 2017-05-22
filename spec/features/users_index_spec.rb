require "rails_helper"

describe "users index" do
  let!(:michael) { create(:michael) }
  let!(:archer) { create(:archer) }
  let!(:users) { create_list(:user, 30) }

  it "index as admin including pagination and delete links" do
    log_in_as(michael)
    visit users_path
    expect(page).to have_selector "nav.pagination"
    User.page(1).each do |user|
      expect(page).to have_link user.name, href: user_path(user)
      unless user == michael
        expect(page).to have_link "delete", href: user_path(user)
      end
    end
    expect {
      page.driver.submit :delete, user_path(archer), {}
    }.to change { User.count }.by(-1)
  end

  it "index as non-admin" do
    log_in_as(archer)
    visit users_path
    expect(page).not_to have_selector "a", text: "delete"
  end
end
