def log_in_as(user)
  visit login_path
  fill_in "session[email]", with: user.email
  fill_in "session[password]", with: user.password
  click_button "Log in"
end
