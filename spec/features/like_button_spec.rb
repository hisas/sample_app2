require "rails_helper"

describe "like button" do
  let!(:michael) { create(:michael) }
  let!(:micropost) { michael.microposts.create(attributes_for(:orange)) }

  before do
    log_in_as(michael)
    visit root_path
  end

  specify "いいねを押すとハートの色が赤に変わり、いいね数が1増えること" do
    expect(page).to have_selector "img#gray_heart_#{micropost.id}"
    expect(page).to have_selector "span#likes_count_#{micropost.id}", text: "0"
    find("#button_#{micropost.id}").click
    expect(page).to have_selector "img#red_heart_#{micropost.id}"
    expect(page).to have_selector "span#likes_count_#{micropost.id}", text: "1"

    # もう一度いいねを押すとハートの色が灰色に戻り、いいね数が1減ること
    find("#button_#{micropost.id}").click
    expect(page).to have_selector "img#gray_heart_#{micropost.id}"
    expect(page).to have_selector "span#likes_count_#{micropost.id}", text: "0"
  end

  specify "いいねを押すと、いいね数が1増えること" do
    expect {
      page.driver.submit :post, micropost_likes_path(micropost), xhr: true
    }.to change { micropost.likes.count }.by(1)
  end
end
