require "rails_helper"

describe "likes" do
  let!(:michael) { create(:michael) }
  let!(:micropost1) { michael.microposts.create(attributes_for(:orange)) }
  let!(:micropost2) { michael.microposts.create(attributes_for(:apple)) }

  before do
    log_in_as(michael)
    visit root_path
    find("#button_#{micropost1.id}").click
    visit likes_microposts_path
  end

  specify "Likesボタンを押すといいねを押した投稿一覧が表示されること" do
    expect(page).to have_content "I just ate an orange!"
    expect(page).not_to have_content "I just ate an apple"
  end
end
