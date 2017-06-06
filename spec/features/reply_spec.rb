require "rails_helper"

describe "reply" do
  let!(:michael) { create(:michael) }
  let!(:archer) { create(:archer) }
  let!(:lana) { create(:lana) }

  before do
    archer.active_relationships.create(followed_id: 1)
    lana.active_relationships.create(followed_id: 1)
  end

  describe "ホーム画面から@ユーザー名をつけて返信する場合" do
    before do
      michael.microposts.create(attributes_for(:reply))
    end

    context "michaelのフィードの場合" do
      before do
        log_in_as(michael)
        visit root_path
      end

      specify "返信が送信者のフィードに表示されること" do
        expect(page).to have_content "@archer hello archer"
      end
    end

    context "archerのフィードの場合" do
      before do
        log_in_as(archer)
        visit root_path
      end

      specify "返信が受信者のフィードに表示されること" do
        expect(page).to have_content "@archer hello archer"
      end
    end

    context "lanaのフィードの場合" do
      before do
        log_in_as(lana)
        visit root_path
      end

      specify "返信が送信者と受信者以外のフィードには表示されないこと" do
        expect(page).not_to have_content "@archer hello archer"
      end
    end
  end

  describe "フィードから、投稿に対して返信する" do
    context "ホーム画面から返信ボタンを押す場合" do
      let!(:postA) { michael.microposts.create(attributes_for(:postA)) }

      before do
        log_in_as(michael)
        visit root_path
        find("#reply_#{postA.id}").click
      end

      specify "フィードから返信ボタンを押して返信することができること" do
        expect {
          fill_in "micropost[content]", with: "5000兆円下さい"
          click_button "Reply"
        }.to change { Micropost.count }.by(1)
        expect(page).to have_content "Reply created!"
      end

      specify "返信に失敗した場合ホーム画面にエラーメッセージが表示されること" do
        expect {
          fill_in "micropost[content]", with: ""
          click_button "Reply"
        }.to change { Micropost.count }.by(0)
        expect(page).to have_content "Reply failed!"
      end
    end

    context "投稿Aに返信（投稿B）がある場合" do
      let!(:postA) { michael.microposts.create(attributes_for(:postA)) }
      let!(:postB) { michael.microposts.create(attributes_for(:postB)) }

      before do
        log_in_as(michael)
      end

      specify "投稿Aへの返信作成ページに、投稿Bが返信一覧に表示されること" do
        visit new_micropost_reply_path(postA)
        expect(page).to have_content "5000兆円欲しいです！"
      end

      specify "投稿Bへの返信作成ページに、投稿Bの前に投稿Aが表示されること" do
        visit new_micropost_reply_path(postB)
        expect(page).to have_content "このツイートに返信してくれたら5000兆円あげます。"
      end
    end
  end
end
