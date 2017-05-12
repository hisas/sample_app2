require "rails_helper"

describe "test microposts search", type: :feature do
  before do
    @michael = create(:michael)
    @archer = create(:archer)
    @lana = create(:lana)
    @malory = create(:malory)

    @lana.microposts.create(attributes_for(:cat_video))
    @malory.microposts.create(attributes_for(:most_recent))
    30.times { @michael.microposts.create(attributes_for(:micropost)) }

    @archer.active_relationships.create(followed_id: 1)
    @archer.active_relationships.create(followed_id: 3)
    @archer.active_relationships.create(followed_id: 4)
  end

  def log_in_as(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end

  it "マイクロポストをテキストの完全一致で検索できること" do
    log_in_as(@archer)
    visit root_path
    fill_in :content, with: "Writing a short test"
    click_button "Search"
    expect(page).to have_content "Writing a short test"
    expect(page).not_to have_content "Sad cats are sad: http://youtu.be/PKffm2uI4dk"
  end

  # it "マイクロポストをテキストのあいまい検索で検索できること" do
  #   log_in_as(@michael)
  #   visit "/users"
  #   fill_in :name, with: "Archer"
  #   click_button "Search"
  #   expect(page).to have_content "Sterling Archer"
  #   expect(page).to have_content "Malory Archer"
  #   expect(page).not_to have_content "Michael Example"
  # end
  #
  # it "合致するマイクロポストがいない場合、メッセージを表示" do
  #   log_in_as(@michael)
  #   visit "/users"
  #   fill_in :name, with: "hisas"
  #   click_button "Search"
  #   expect(page).to have_content "no match for hisas"
  # end
  #
  # it "合致するマイクロポストが多い場合、ページネーション" do
  #   log_in_as(@michael)
  #   visit "/users"
  #   fill_in :name, with: ""
  #   click_button "Search"
  #   expect(page).to have_selector "nav.pagination"
  # end
end
