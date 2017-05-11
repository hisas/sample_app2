require "rails_helper"

describe RelationshipsController, type: :controller do
  before do
    @michael = create(:michael)
    @archer = create(:archer)
    @lana = create(:lana)
    @michael.active_relationships.create(followed_id: 3)
  end

  it "create should require logged-in user" do
    expect { page.driver.submit :post, relationships_path, params: {} }.to change { Relationship.count }.by(0)
    expect(current_path).to eq login_path
  end

  it "destroy should require logged-in user" do
    expect { page.driver.submit :delete, "/relationships/1", params: {} }.to change { Relationship.count }.by(0)
    expect(current_path).to eq login_path
  end
end
