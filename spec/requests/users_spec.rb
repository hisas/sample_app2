require "rails_helper"

describe "Users", type: :request do
  let(:valid_params) { { name: "hisas", email: "hisas@gmail.com", password: "foobar", password_confirmation: "foobar" } }
  let(:invalid_params) { { name: "", email: "", password: "", password_confirmation: "" } }
  let!(:michael) { create(:michael) }
  let!(:users) { create_list(:user, 30) }
  subject(:json) { JSON.parse(response.body) }

  describe "GET /api/v1/users" do
    before do
      get api_v1_users_path format: :json
    end

    it "ユーザー一覧を取得できること" do
      expect(response.status).to eq 200
      expect(json.size).to eq users.count + 1
      expect(json[1]["id"]).to eq users[0].id
      expect(json[2]["id"]).to eq users[1].id
    end
  end

  describe "GET /api/v1/users/:id" do
    before do
      get api_v1_user_path(michael.id, format: :json)
    end

    it "指定したユーザーを取得できること" do
      expect(response.status).to eq 200
      expect(json["id"]).to eq michael.id
      expect(json["name"]).to eq michael.name
    end
  end

  describe "POST /api/v1/users" do
    it "ユーザーを作成できること" do
      expect {
        post api_v1_users_path(format: :json), params: valid_params
      }.to change { User.count }.by(1)

      expect(response.status).to eq 201
      expect(json["name"]).to eq valid_params[:name]
      expect(json["email"]).to eq valid_params[:email]
    end

    it "有効ではないparamsではユーザーを作成できないこと" do
      expect {
        post api_v1_users_path(format: :json), params: invalid_params
      }.to change { User.count }.by(0)

      expect(response.status).to eq 422
      expect(json["name"]).to eq ["can't be blank"]
      expect(json["email"]).to eq ["can't be blank", "is invalid"]
    end
  end

  describe "PATCH /api/v1/users/:id" do
    it "ユーザー情報を編集できること" do
      patch api_v1_user_path(michael.id, format: :json), params: valid_params

      expect(response.status).to eq 200
      expect(json["name"]).to eq valid_params[:name]
      expect(json["email"]).to eq valid_params[:email]
    end

    it "有効ではないparamsではユーザーを編集できないこと" do
      patch api_v1_user_path(michael.id, format: :json), params: invalid_params

      expect(response.status).to eq 422
      expect(json["name"]).to eq ["can't be blank"]
      expect(json["email"]).to eq ["can't be blank", "is invalid"]
    end
  end

  describe "DELETE /api/v1/users/:id" do
    it "ユーザーを削除できること" do
      expect {
        delete api_v1_user_path(michael.id, format: :json), params: valid_params
      }.to change { User.count }.by(-1)

      expect(response.status).to eq 204
    end
  end
end
