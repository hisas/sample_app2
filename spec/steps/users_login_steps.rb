# encoding: utf-8

step "トップページにアクセスする" do
  visit root_path
end

step "ユーザーがログインページにアクセスする" do
  @user = create(:michael)
  visit login_path
end

step "有効なメールアドレスとパスワードを入力する" do
  fill_in "Email", with: @user.email
  fill_in "Password", with: "password"
end

step "有効ではないメールアドレスとパスワードを入力する" do
  fill_in "Email", with: ""
  fill_in "Password", with: ""
end

step "ログインボタンをクリックする" do
  click_button "Log in"
end

step "画面にログインURLが表示されないこと" do
  expect(page).not_to have_link "Log in", href: login_path
end

step "画面にログアウトURLが表示されること" do
  expect(page).to have_link "Log out", href: logout_path
end

step "画面にユーザープロフィールURLが表示されること" do
  expect(page).to have_link "Profile", href: user_path(@user)
end

step "画面にエラーメッセージが表示されること" do
  expect(page).to have_content "Invalid email/password combination"
end

step "画面にエラーメッセージが表示されないこと" do
  expect(page).not_to have_content "Invalid email/password combination"
end
