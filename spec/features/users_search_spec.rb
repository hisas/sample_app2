require "rails_helper"

describe "test users search", type: :feature do
  before do
    @michael = create(:michael)
    @archer = create(:archer)
    @malory = create(:malory)
    30.times { create(:user) }
  end

  it "ユーザーを名前の完全一致で検索できる" do
    log_in_as(@michael)
    visit "/users"
    fill_in :name, with: "Michael Example"
    click_button "Search"
    expect(page).to have_content "Michael Example"
    expect(page).not_to have_content "Sterling Archer"
  end

  it "ユーザーを名前のあいまい検索で検索できること" do
    log_in_as(@michael)
    visit "/users"
    fill_in :name, with: "Archer"
    click_button "Search"
    expect(page).to have_content "Sterling Archer"
    expect(page).to have_content "Malory Archer"
    expect(page).not_to have_content "Michael Example"
  end

  it "合致するユーザがいない場合、メッセージを表示" do
    log_in_as(@michael)
    visit "/users"
    fill_in :name, with: "hisas"
    click_button "Search"
    expect(page).to have_content "no match for hisas"
  end

  it "合致するユーザが多い場合、ページネーション" do
    log_in_as(@michael)
    visit "/users"
    fill_in :name, with: ""
    click_button "Search"
    expect(page).to have_selector "nav.pagination"
  end
end
