require "rails_helper"

describe "like button" do
  let!(:michael) { create(:michael) }
  let!(:micropost) { michael.microposts.create(attributes_for(:orange)) }

  before do
    log_in_as(michael)
    visit root_path
  end

  specify "いいねを押すとハートの色が赤に変わり、いいね数とアイコンが1増えること" do
    expect(page).to have_selector "img#gray_heart_#{micropost.id}"
    expect(page).to have_selector "span#likes_count_#{micropost.id}", text: "0"
    expect(page).not_to have_selector "img#avatar_#{michael.id}"
    find("#button_#{micropost.id}").click
    expect(page).to have_selector "img#red_heart_#{micropost.id}"
    expect(page).to have_selector "span#likes_count_#{micropost.id}", text: "1"
    expect(page).not_to have_selector "img#avatar_#{michael.id}"

    # もう一度いいねを押すとハートの色が灰色に戻り、いいね数とアイコンが1減ること
    find("#button_#{micropost.id}").click
    expect(page).to have_selector "img#gray_heart_#{micropost.id}"
    expect(page).to have_selector "span#likes_count_#{micropost.id}", text: "0"
    expect(page).not_to have_selector "img#avatar_#{michael.id}"
  end
end
