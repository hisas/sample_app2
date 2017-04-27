require "rails_helper"

describe "test user_mailer", type: :mailer do
  it "account_activation" do
    user = create(:michael)
    user.activation_token = User.new_token
    mail = UserMailer.account_activation(user)
    expect(mail.subject).to eq("Account activation")
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(["noreply@example.com"])
    expect(mail.body.encoded).to match(user.name)
    expect(mail.body.encoded).to match(user.activation_token)
    expect(mail.body.encoded).to match(CGI.escape(user.email))
  end

  it "password_reset" do
    user = create(:michael)
    user.reset_token = User.new_token
    mail = UserMailer.password_reset(user)
    expect(mail.subject).to eq("Password reset")
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(["noreply@example.com"])
    expect(mail.body.encoded).to match(user.reset_token)
    expect(mail.body.encoded).to match(CGI.escape(user.email))
  end
end
