require "rails_helper"

describe SessionsHelper, type: :helper do
  before do
    @user = create(:michael)
    remember(@user)
  end

  it "current_user returns right user when session is nil" do
    expect(@user).to eq current_user
    expect(!session[:user_id].nil?).to eq true
  end

  it "current_user returns nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    expect(current_user).to eq nil
  end
end
