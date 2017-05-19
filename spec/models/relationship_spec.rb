require "rails_helper"

describe Relationship, type: :model do
  let!(:michael) { create(:michael) }
  let!(:archer) { create(:archer) }
  let!(:relationship) { Relationship.new(follower_id: michael.id, followed_id: archer.id) }

  it "should be valid" do
    expect(relationship).to be_valid
  end

  it "should require a follower_id" do
    relationship.follower_id = nil
    expect(relationship).not_to be_valid
  end

  it "should require a followed_id" do
    relationship.followed_id = nil
    expect(relationship).not_to be_valid
  end
end
