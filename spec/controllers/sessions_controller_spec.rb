require "rails_helper"

describe SessionsController do
  describe "GET #new" do
    before do
      visit login_path
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end
end
