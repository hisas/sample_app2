require "rails_helper"

describe "microposts interface", type: :feature do
  before do
    @user = create(:michael)
    30.times { @user.microposts.create(attributes_for(:micropost)) }
  end

  it "micropost interface" do
    log_in_as(@user)
    visit root_path
    expect(page).to have_selector "nav.pagination"
    # 無効な送信
    expect {
      fill_in "micropost_content", with: ""
      click_button "Post"
    }.to change { Micropost.count }.by(0)
    expect(page).to have_selector "div#error_explanation"
    # 有効な送信
    expect {
      fill_in "micropost_content", with: "This micropost really ties the room together"
      click_button "Post"
    }.to change { Micropost.count }.by(1)
    expect(current_path).to eq root_path
    expect(page).to have_content "This micropost really ties the room together"
    # 投稿を削除する
    expect(page).to have_selector "a", text: "delete"
    first_micropost = @user.microposts.page(1).first
    expect { first("ol li").click_link "delete" }.to change { Micropost.count }.by(-1)
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    visit user_path(create(:archer))
    expect(page).not_to have_selector "a", text: "delete"
  end
end
