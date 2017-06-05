require "rails_helper"

describe "reply" do
  let!(:michael) { create(:michael) }
  let!(:archer) { create(:archer) }
  let!(:lana) { create(:lana) }

  before do
    archer.active_relationships.create(followed_id: 1)
    lana.active_relationships.create(followed_id: 1)

    michael.microposts.create(attributes_for(:reply))
  end

  context "michaelのフィードの場合" do
    before do
      log_in_as(michael)
      visit root_path
    end
    it "返信が送信者のフィードに表示されること" do
      expect(page).to have_content "@archer hello archer"
    end
  end

  context "archerのフィードの場合" do
    before do
      log_in_as(archer)
      visit root_path
    end
    it "返信が受信者のフィードに表示されること" do
      expect(page).to have_content "@archer hello archer"
    end
  end

  context "lanaのフィードの場合" do
    before do
      log_in_as(lana)
      visit root_path
    end
    it "返信が送信者と受信者以外のフィードには表示されないこと" do
      expect(page).not_to have_content "@archer hello archer"
    end
  end
end
