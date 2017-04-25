require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      visit login_path
      expect(response).to have_http_status(:success)
    end
  end

end
