require 'rails_helper'

describe "test users_controller", type: :feature do
  it "should get new" do
    visit signup_path
    expect(page).to have_http_status(:success)
    expect(page).to have_selector 'title', exact_text: "Sign up | Ruby on Rails Tutorial Sample App", visible: false
  end
end
