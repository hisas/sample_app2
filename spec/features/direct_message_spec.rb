require "rails_helper"

describe "direct message" do
  let!(:michael) { create(:michael) }
  let!(:archer) { create(:archer) }

  describe "DMを始めるために話したいユーザーとの部屋を作る" do
    before do
      log_in_as(michael)
      visit new_room_path
    end

    context "正しいnicknameを指定する場合" do
      specify "新しく部屋を作成できること" do
        expect {
          fill_in "room[other_user_id]", with: "archer"
          click_button "Add"
        }.to change { Room.count }.by(1)
        expect(page).to have_content "Room added!"
      end
    end

    context "存在しないnicknameを指定する場合" do
      specify "部屋を作成できず、エラーメッセージが表示されること" do
        expect {
          fill_in "room[other_user_id]", with: "hoge"
          click_button "Add"
        }.to change { Room.count }.by(0)
        expect(page).to have_content "User not found"
      end
    end
  end

  describe "MichaelがArcherと会話する", js: true do
    let!(:room) { michael.rooms.create(other_user_id: archer.id) }

    before do
      log_in_as(michael)
      visit room_path(room)
    end

    context "2文字以上入力する場合" do
      xit "メッセージを送信できること" do
        expect {
          fill_in "message[content]", with: "Hello Archer"
          click_button "Post"
        }.to change { Message.count }.by(1)
        expect(page).to have_content "Hello Archer"
      end
    end

    context "1文字以下入力する場合" do
      xit "メッセージを送信できないこと" do
        expect {
          fill_in "message[content]", with: "a"
          click_button "Post"
        }.to change { Message.count }.by(0)
        expect(page).not_to have_content "a"
      end
    end
  end
end
