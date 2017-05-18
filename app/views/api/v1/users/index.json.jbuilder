json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :created_at, :updated_at, :admin
  json.url api_v1_user_url(user, format: :json)
end
