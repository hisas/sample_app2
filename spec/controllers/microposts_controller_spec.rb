require "rails_helper"

describe MicropostsController, type: :controller do
  let!(:michael) { create(:michael) }
  let!(:archer) { create(:archer) }
  let!(:micropost1) { michael.microposts.create(attributes_for(:orange)) }
  let!(:micropost2) { archer.microposts.create(attributes_for(:tau_manifesto)) }

  it "should redirect create when not logged in" do
    expect {
      page.driver.submit :post, microposts_path, params: { micropost: { content: "Lorem ipsum" } }
    }.to change { Micropost.count }.by(0)
    expect(current_path).to eq login_path
  end

  it "should redirect destroy when not logged in" do
    expect {
      page.driver.submit :delete, micropost_path(micropost1), {}
    }.to change { Micropost.count }.by(0)
    expect(current_path).to eq login_path
  end

  it "should redirect destroy for wrong micropost" do
    log_in_as(michael)
    expect {
      page.driver.submit :delete, micropost_path(micropost2), {}
    }.to change { Micropost.count }.by(0)
    expect(current_path).to eq root_path
  end
end
