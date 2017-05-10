require "rails_helper"

describe MicropostsController, type: :controller do
  before do
    @user = create(:michael)
    @micropost = @user.microposts.create(attributes_for(:orange))
    @other_user = create(:archer)
  end

  it "should redirect create when not logged in" do
    expect { page.driver.submit :post, microposts_path, params: { micropost: { content: "Lorem ipsum" } } }.to change { Micropost.count }.by(0)
    expect(current_path).to eq login_path
  end

  it "should redirect destroy when not logged in" do
    expect { page.driver.submit :delete, micropost_path(@micropost), {} }.to change { Micropost.count }.by(0)
    expect(current_path).to eq login_path
  end

  it "should redirect destroy for wrong micropost" do
    log_in_as(@user)
    micropost = @other_user.microposts.create(attributes_for(:tau_manifesto))
    expect { page.driver.submit :delete, micropost_path(micropost), {} }.to change { Micropost.count }.by(0)
    expect(current_path).to eq root_path
  end
end
