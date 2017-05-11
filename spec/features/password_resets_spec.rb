require "rails_helper"

describe "password_resets", type: :feature do
  before do
    ActionMailer::Base.deliveries.clear
    @user = create(:michael)
  end

  it "password resets" do
    visit new_password_reset_path
    # メールアドレスが無効
    fill_in "Email", with: ""
    click_button "Submit"
    expect(page).to have_content "Email address not found"
    # メールアドレスが有効
    fill_in "Email", with: @user.email
    click_button "Submit"
    expect(@user.reset_digest).not_to eq @user.reload.reset_digest
    expect(ActionMailer::Base.deliveries.size).to eq 1
    expect(page).to have_content "Email sent with password reset instructions"
    expect(current_path).to eq root_path
    # パスワード再設定フォームのテスト
    # メールアドレスが無効
    visit edit_password_reset_path(@user.reset_token, email: "", id: @user.id)
    expect(current_path).to eq root_path
    # 無効なユーザー
    @user.toggle!(:activated)
    visit edit_password_reset_path(@user.reset_token, email: @user.email, id: @user.id)
    expect(current_path).to eq root_path
    @user.toggle!(:activated)
    # メールアドレスが有効で、トークンが無効
    visit edit_password_reset_path("wrong token", email: @user.email, id: @user.id)
    expect(current_path).to eq root_path
    # メールアドレスもトークンも有効
    visit edit_password_reset_path(@user.reset_token, email: @user.email, id: @user.id)
  end
end
