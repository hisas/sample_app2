require "rails_helper"

describe "Users" do
  let!(:michael) { create(:michael) }
  let!(:micropost) { michael.microposts.create(attributes_for(:orange)) }

  describe "GET /users/:id/microposts_feed" do
    before do
      get microposts_feed_user_path(michael.id, format: :rss)
    end

    it "ユーザーのマイクロポストのRSSフィードが表示されること" do
      expect(response.status).to eq 200
      expect(response.body).to match "I just ate an orange!"
      expect(response.content_type).to eq "application/rss+xml"
    end
  end
end
