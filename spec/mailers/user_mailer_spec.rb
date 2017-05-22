require "rails_helper"

describe UserMailer do
  let!(:michael) { create(:michael) }

  it "account_activation" do
    michael.activation_token = User.new_token
    mail = UserMailer.account_activation(michael)
    expect(mail.subject).to eq("Account activation")
    expect(mail.to).to eq([michael.email])
    expect(mail.from).to eq(["noreply@example.com"])
    expect(mail.body.encoded).to match(michael.name)
    expect(mail.body.encoded).to match(michael.activation_token)
    expect(mail.body.encoded).to match(CGI.escape(michael.email))
  end

  it "password_reset" do
    michael.reset_token = User.new_token
    mail = UserMailer.password_reset(michael)
    expect(mail.subject).to eq("Password reset")
    expect(mail.to).to eq([michael.email])
    expect(mail.from).to eq(["noreply@example.com"])
    expect(mail.body.encoded).to match(michael.reset_token)
    expect(mail.body.encoded).to match(CGI.escape(michael.email))
  end
end
