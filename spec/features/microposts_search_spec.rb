require "rails_helper"

describe "microposts search", type: :feature do
  let!(:michael) { create(:michael) }
  let!(:archer) { create(:archer) }
  let!(:lana) { create(:lana) }
  let!(:malory) { create(:malory) }

  before do
    lana.microposts.create(attributes_for(:cat_video))
    malory.microposts.create(attributes_for(:most_recent))
    michael.microposts.create(attributes_for(:orange))
    michael.microposts.create(attributes_for(:apple))
    30.times { michael.microposts.create(attributes_for(:micropost)) }

    archer.active_relationships.create(followed_id: 1)
    archer.active_relationships.create(followed_id: 3)
    archer.active_relationships.create(followed_id: 4)
  end

  it "root_pathでマイクロポストをcontentの完全一致で検索できること" do
    log_in_as(archer)
    visit root_path
    fill_in :content, with: "Writing a short test!"
    click_button "Search"
    expect(page).to have_content "Writing a short test!"
    expect(page).not_to have_content "Sad cats are sad: http://youtu.be/PKffm2uI4dk"
  end

  it "user_pathでマイクロポストをcontentの完全一致で検索できること" do
    log_in_as(michael)
    visit "/users/#{michael.id}"
    fill_in :content, with: "I just ate an orange!"
    click_button "Search"
    expect(page).to have_content "I just ate an orange!"
    expect(page).not_to have_content "I just ate an apple"
  end

  it "マイクロポストをcontentのあいまい検索で検索できること" do
    log_in_as(archer)
    visit root_path
    fill_in :content, with: "!"
    click_button "Search"
    expect(page).to have_content "Writing a short test!"
    expect(page).to have_content "I just ate an orange!"
    expect(page).not_to have_content "Sad cats are sad: http://youtu.be/PKffm2uI4dk"
  end

  it "合致するマイクロポストがない場合、メッセージを表示" do
    log_in_as(archer)
    visit root_path
    fill_in :content, with: "hisas"
    click_button "Search"
    expect(page).to have_content "no match for hisas"
  end

  it "合致するマイクロポストが多い場合、ページネーション" do
    log_in_as(archer)
    visit root_path
    fill_in :content, with: ""
    click_button "Search"
    expect(page).to have_selector "nav.pagination"
  end
end
