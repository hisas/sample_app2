require "rails_helper"

describe SessionsHelper do
  let!(:michael) { create(:michael) }

  before do
    remember(michael)
  end

  it "current_user returns right user when session is nil" do
    expect(michael).to eq current_user
    expect(!session[:user_id].nil?).to be true
  end

  it "current_user returns nil when remember digest is wrong" do
    michael.update_attribute(:remember_digest, User.digest(User.new_token))
    expect(current_user).to eq nil
  end
end
