require "rails_helper"

describe "test users search", type: :feature do
  before do
    @michael = create(:michael)
    @archer = create(:archer)
    @malory = create(:malory)
  end

  def log_in_as(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  it "ユーザーを名前の完全一致で検索できる" do
    log_in_as(@michael)
    visit "/users"
    fill_in :name, with: "Michael Example"
    click_button "Search"
    expect(page).to have_content "Michael Example"
    expect(page).not_to have_content "Sterling Archer"
  end

  # ユーザ名はユニークじゃなさそうだけどどうするか
  # 合致するユーザが複数いる場合は？
  # case insensitive な検索をするかどうか
  # アクティベート前のユーザーは検索可能か
  it "ユーザーを名前のあいまい検索で検索できること" do
    log_in_as(@michael)
    visit "/users"
    fill_in :name, with: "Archer"
    click_button "Search"
    expect(page).to have_content "Sterling Archer"
    expect(page).to have_content "Malory Archer"
    expect(page).not_to have_content "Michael Example"
  end
  it "合致するユーザがいない場合：どうする？"
end
