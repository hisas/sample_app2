require "rails_helper"

RSpec.describe Micropost, type: :model do
  before do
    @user = create(:michael)
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  it "should be valid" do
    expect(@micropost).to be_valid
  end

  it "user id should be present" do
    @micropost.user_id = nil
    expect(@micropost).not_to be_valid
  end

  it "content should be present" do
    @micropost.content = "   "
    expect(@micropost).not_to be_valid
  end

  it "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    expect(@micropost).not_to be_valid
  end

  it "order should be most recent first" do
    expect(@user.microposts.create(attributes_for(:most_recent))).to eq Micropost.first
  end
end
