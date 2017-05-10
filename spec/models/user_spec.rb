require "rails_helper"

RSpec.describe User, type: :model do
  before do
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  it "should be valid" do
    expect(@user).to be_valid
  end

  it "name should be present" do
    @user.name = " "
    expect(@user).not_to be_valid
  end

  it "email should be present" do
    @user.email = " "
    expect(@user).not_to be_valid
  end

  it "name should not be too long" do
    @user.name = "a" * 51
    expect(@user).not_to be_valid
  end

  it "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    expect(@user).not_to be_valid
  end

  it "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      expect(@user).to be_valid, "#{valid_address.inspect} should be valid"
    end
  end

  it "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      expect(@user).not_to be_valid, "#{invalid_address.inspect} should be invalid"
    end
  end

  it "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    expect(duplicate_user).not_to be_valid
  end

  it "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    expect(mixed_case_email.downcase).to eq(@user.reload.email)
  end

  it "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    expect(@user).not_to be_valid
  end

  it "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    expect(@user).not_to be_valid
  end

  it "authenticated? should return false for a user with nil digest" do
    expect(@user.authenticated?(:remember, "")).not_to eq true
  end

  it "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    expect { @user.destroy }.to change { Micropost.count }.by(-1)
  end

  it "should follow and unfollow a user" do
    michael = create(:michael)
    archer = create(:archer)
    expect(michael.following?(archer)).to eq false
    michael.follow(archer)
    expect(michael.following?(archer)).to eq true
    expect(archer.followers.include?(michael)).to eq true
    michael.unfollow(archer)
    expect(michael.following?(archer)).to eq false
  end

  it "feed should have the right posts" do
    michael = create(:michael)
    archer = create(:archer)
    lana = create(:lana)
    # フォローしているユーザーの投稿を確認
    lana.microposts.each do |post_following|
      expect(michael.feed.include?(post_following)).to eq true
    end
    # 自分自身の投稿を確認
    michael.microposts.each do |post_self|
      expect(michael.feed.include?(post_self)).to eq true
    end
    # フォローしていないユーザーの投稿を確認
    archer.microposts.each do |post_unfollowed|
      expect(michael.feed.include?(post_unfollowed)).to eq true
    end
  end
end
