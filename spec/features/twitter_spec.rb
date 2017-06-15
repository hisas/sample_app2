require "rails_helper"

describe "Twitter" do
  describe "Sign up with Twitter" do
    before do
      visit root_path
    end

    it "Twitterアカウントでユーザー登録できること" do
      expect {
        click_on "Sign up with Twitter"
      }.to change { User.count }.by(1)
    end
  end

  describe "Log in with Twitter" do
    let!(:mock) { create(:mock) }

    before do
      visit login_path
    end

    it "Twitterアカウントでログインできること" do
      expect {
        click_on "Log in with Twitter"
      }.to change { User.count }.by(0)
      expect(current_path).to eq user_path(mock)
    end
  end
end
