require "rails_helper"

describe "test users_controller", type: :controller do
  before do
    @user = create(:michael)
    @other_user = create(:archer)
  end

  it "should get new" do
    visit signup_path
    expect(page).to have_http_status(:success)
    expect(page).to have_selector "title", exact_text: "Sign up | Ruby on Rails Tutorial Sample App", visible: false
  end

  it "should redirect edit when not logged in" do
    visit edit_user_path(@user)
    expect(page).to have_content "Please log in."
    expect(current_path).to eq(login_path)
  end

  it "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    visit edit_user_path(@user)
    expect(page).not_to have_content "Please log in."
    expect(current_path).to eq(root_path)
  end

  it "should redirect index when not logged in" do
    visit users_path
    expect(current_path).to eq(login_path)
  end

  it "should redirect destroy when not logged in" do
    count = User.count
    page.driver.submit :delete, user_path(@user), {}
    expect(count).to eq(User.count)
    expect(current_path).to eq(login_path)
  end

  it "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    count = User.count
    page.driver.submit :delete, user_path(@user), {}
    expect(count).to eq(User.count)
    expect(current_path).to eq(root_path)
  end

  it "should redirect following when not logged in" do
    visit following_user_path(@user)
    expect(current_path).to eq(login_path)
  end

  it "should redirect followers when not logged in" do
    visit followers_user_path(@user)
    expect(current_path).to eq(login_path)
  end
end
