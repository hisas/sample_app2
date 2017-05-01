require "rails_helper"

RSpec.describe RelationshipsController, type: :controller do
  before do
    @michael = create(:michael)
    @archer = create(:archer)
    @lana = create(:lana)
    @michael.active_relationships.create(followed_id: 3)
  end

  it "create should require logged-in user" do
    count = Relationship.count
    page.driver.submit :post, relationships_path, params: {}
    expect(count).to eq Relationship.count
    expect(current_path).to eq login_path
  end

  it "destroy should require logged-in user" do
    count = Relationship.count
    page.driver.submit :delete, "/relationships/1", params: {}
    expect(count).to eq Relationship.count
    expect(current_path).to eq login_path
  end
end
