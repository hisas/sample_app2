require "rails_helper"

describe "following", type: :feature do
  before do
    @michael = create(:michael)
    @archer = create(:archer)
    @lana = create(:lana)
    @malory = create(:malory)

    @michael.active_relationships.create(id: 1, followed_id: 3)
    @michael.active_relationships.create(id: 2, followed_id: 4)
    @lana.active_relationships.create(id: 3, followed_id: 1)
    @archer.active_relationships.create(id: 4, followed_id: 1)

    log_in_as(@michael)
  end

  it "following page" do
    visit following_user_path(@michael)
    expect(@michael.following.empty?).to eq false
    expect(page).to have_content @michael.following.count.to_s
    @michael.following.each do |user|
      expect(page).to have_content user.name
    end
  end

  it "followers page" do
    visit followers_user_path(@michael)
    expect(@michael.followers.empty?).to eq false
    expect(page).to have_content @michael.followers.count.to_s
    @michael.followers.each do |user|
      expect(page).to have_content user.name
    end
  end

  it "should follow a user the standard way" do
    expect { page.driver.submit :post, relationships_path, followed_id: @archer.id }.to change { @michael.following.count }.by(1)
  end

  it "should follow a user with Ajax" do
    expect { page.driver.submit :post, relationships_path, xhr: true, followed_id: @archer.id }.to change { @michael.following.count }.by(1)
  end

  it "should unfollow a user the standard way" do
    @michael.active_relationships.create(id: 5, followed_id: 2)
    expect { page.driver.submit :delete, "/relationships/5", params: {} }.to change { @michael.following.count }.by(-1)
  end

  it "should unfollow a user with Ajax" do
    @michael.active_relationships.create(id: 5, followed_id: 2)
    expect { page.driver.submit :delete, "/relationships/5", xhr: true, params: {} }.to change { @michael.following.count }.by(-1)
  end
end
