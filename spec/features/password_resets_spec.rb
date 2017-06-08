require "rails_helper"

describe "password_resets" do
  let!(:michael) { create(:michael) }

  before do
    log_in_as(michael)
    ActionMailer::Base.deliveries.clear
  end

  it "password resets" do
    visit new_password_reset_path
    # メールアドレスが無効
    fill_in "password_reset[email]", with: ""
    click_button "Submit"
    expect(page).to have_content "Email address not found"
    # メールアドレスが有効
    fill_in "password_reset[email]", with: michael.email
    click_button "Submit"
    expect(michael.reset_digest).not_to eq michael.reload.reset_digest
    expect(ActionMailer::Base.deliveries.size).to eq 1
    expect(page).to have_content "Email sent with password reset instructions"
    expect(current_path).to eq root_path
    # パスワード再設定フォームのテスト
    # メールアドレスが無効
    visit edit_password_reset_path(michael.reset_token, email: "", id: michael.id)
    expect(current_path).to eq root_path
    # 無効なユーザー
    michael.toggle!(:activated)
    visit edit_password_reset_path(michael.reset_token, email: michael.email, id: michael.id)
    expect(current_path).to eq root_path
    michael.toggle!(:activated)
    # メールアドレスが有効で、トークンが無効
    visit edit_password_reset_path("wrong token", email: michael.email, id: michael.id)
    expect(current_path).to eq root_path
    # メールアドレスもトークンも有効
    visit edit_password_reset_path(michael.reset_token, email: michael.email, id: michael.id)
  end
end
